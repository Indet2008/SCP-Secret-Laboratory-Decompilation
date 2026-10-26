using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.Usables;
using LabApi.Events.Arguments.ObjectiveEvents;
using LabApi.Events.Handlers;
using PlayerRoles;
using Scp914;

namespace Respawning.Objectives
{
	public class ScpItemPickupObjective : HumanObjectiveBase<PickupObjectiveFootprint>
	{
		private const float PickupItemTimer = -5f;

		private const float PickupItemInfluence = 1f;

		private const float PickupConsumableTimer = -2f;

		private const float PickupConsumableInfluence = 1f;

		private static readonly HashSet<ushort> BlacklistedItems = new HashSet<ushort>();

		protected override PickupObjectiveFootprint ClientCreateFootprint()
		{
			return new PickupObjectiveFootprint();
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			InventoryExtensions.OnItemAdded += OnItemAdded;
			Scp914Upgrader.OnUpgraded += OnPickupUpgraded;
		}

		protected override void OnInstanceReset()
		{
			base.OnInstanceReset();
			BlacklistedItems.Clear();
		}

		private void OnPickupUpgraded(Scp914Result result, Scp914KnobSetting _)
		{
			if (result.ResultingPickups != null)
			{
				ItemPickupBase[] resultingPickups = result.ResultingPickups;
				foreach (ItemPickupBase itemPickupBase in resultingPickups)
				{
					if (!(itemPickupBase == null))
					{
						BlacklistedItems.Add(itemPickupBase.Info.Serial);
					}
				}
			}
			if (result.ResultingItems == null)
			{
				return;
			}
			ItemBase[] resultingItems = result.ResultingItems;
			foreach (ItemBase itemBase in resultingItems)
			{
				if (!(itemBase == null))
				{
					BlacklistedItems.Add(itemBase.ItemSerial);
				}
			}
		}

		private void OnItemAdded(ReferenceHub hub, ItemBase item, ItemPickupBase pickup)
		{
			if (pickup == null || item.Category != ItemCategory.SCPItem || item.ItemTypeId == ItemType.SCP330 || item.ServerAddReason == ItemAddReason.Scp914Upgrade || !BlacklistedItems.Add(pickup.Info.Serial))
			{
				return;
			}
			Faction faction = hub.GetFaction();
			float timeToGrant;
			float influenceToGrant;
			if (item is Consumable)
			{
				influenceToGrant = 1f;
				timeToGrant = -2f;
			}
			else
			{
				influenceToGrant = 1f;
				timeToGrant = -5f;
			}
			bool sendToPlayers = true;
			ScpItemPickingObjectiveEventArgs e = new ScpItemPickingObjectiveEventArgs(hub, faction, influenceToGrant, timeToGrant, item, sendToPlayers);
			ObjectiveEvents.OnPickingScpItemCompleting(e);
			if (!e.IsAllowed)
			{
				return;
			}
			ObjectiveEvents.OnCompleting(e);
			if (e.IsAllowed)
			{
				hub = e.Player?.ReferenceHub;
				faction = e.Faction;
				timeToGrant = e.TimeToGrant;
				influenceToGrant = e.InfluenceToGrant;
				sendToPlayers = e.SendToPlayers;
				GrantInfluence(faction, influenceToGrant);
				ReduceTimer(faction, timeToGrant);
				if (sendToPlayers)
				{
					base.ObjectiveFootprint = new PickupObjectiveFootprint
					{
						AchievingPlayer = new ObjectiveHubFootprint(hub),
						InfluenceReward = influenceToGrant,
						TimeReward = timeToGrant,
						PickupType = item.ItemTypeId
					};
					ServerSendUpdate();
				}
				ScpItemPickedObjectiveEventArgs ev = new ScpItemPickedObjectiveEventArgs(hub, faction, influenceToGrant, timeToGrant, sendToPlayers, item);
				ObjectiveEvents.OnPickedScpItemCompleted(ev);
				ObjectiveEvents.OnCompleted(ev);
			}
		}
	}
}
