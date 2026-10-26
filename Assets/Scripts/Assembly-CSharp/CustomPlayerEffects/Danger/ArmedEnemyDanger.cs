using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Jailbird;
using PlayerRoles;
using PlayerRoles.PlayableScps;

namespace CustomPlayerEffects.Danger
{
	public class ArmedEnemyDanger : EncounterDangerBase
	{
		public override bool IsActive
		{
			get
			{
				UpdateState();
				return base.IsActive;
			}
			protected set
			{
				base.IsActive = value;
			}
		}

		public override float DangerPerEncounter { get; } = 1f;

		public override float DangerPerAdditionalEncounter { get; } = 0.25f;

		private void UpdateState()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub == base.Owner || !allHub.IsHuman())
				{
					continue;
				}
				if (!HitboxIdentity.IsEnemy(base.Owner, allHub))
				{
					break;
				}
				if (VisionInformation.IsInView(base.Owner, allHub) && IsArmed(allHub))
				{
					if (WasEncounteredRecently(allHub, out var cachedEncounter))
					{
						cachedEncounter.TimeTracker.Restart();
					}
					else
					{
						RegisterEncounter(allHub);
					}
				}
			}
		}

		private bool IsArmed(ReferenceHub hub)
		{
			foreach (ItemBase value in hub.inventory.UserInventory.Items.Values)
			{
				if (value is Firearm || value is JailbirdItem)
				{
					return true;
				}
			}
			return false;
		}
	}
}
