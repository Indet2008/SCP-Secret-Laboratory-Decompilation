using System;
using System.Collections.Generic;
using Hazards;
using InventorySystem.Items.Pickups;
using Mirror;
using NetworkManagerUtils.Dummies;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class Scp330Bag : UsableItem, IAcquisitionConfirmationTrigger, IUniqueItem
	{
		public const int MaxCandies = 6;

		public const int NoSelectionIndex = -1;

		public TantrumEnvironmentalHazard TantrumPrefab;

		public int SelectedCandyId { get; set; } = -1;

		public List<CandyKindID> Candies { get; set; } = new List<CandyKindID>();

		public override bool CountsTowardsCategoryLimit { get; }

		public override bool CanStartUsing => false;

		public bool AcquisitionAlreadyReceived { get; set; }

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.Scp330Bag;

		public bool IsCandySelected
		{
			get
			{
				if (SelectedCandyId >= 0)
				{
					return SelectedCandyId < Candies.Count;
				}
				return false;
			}
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active && ServerProcessPickup(base.Owner, pickup as Scp330Pickup, out var bag) && !(bag == null) && !(bag == this))
			{
				ServerRemoveSelf();
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (NetworkServer.active && pickup is Scp330Pickup scp330Pickup && scp330Pickup != null)
			{
				scp330Pickup.StoredCandies = Candies;
			}
		}

		public override void OnEquipped()
		{
			SelectedCandyId = -1;
		}

		public override void OnHolstered()
		{
			IsUsing = false;
		}

		public void ServerConfirmAcqusition()
		{
			ServerRefreshBag();
		}

		public override void ServerOnUsingCompleted()
		{
			if (IsCandySelected)
			{
				IsUsing = false;
				if (Scp330Candies.CandiesById.TryGetValue(Candies[SelectedCandyId], out var value))
				{
					value.ServerApplyEffects(base.Owner);
				}
				Candies.RemoveAt(SelectedCandyId);
				base.OwnerInventory.ServerSelectItem(0);
				ServerRefreshBag();
			}
		}

		public void DropCandy(int index)
		{
			SendClientMessage(index, drop: true);
		}

		public void SelectCandy(int index)
		{
			SelectedCandyId = index;
			SendClientMessage(index, drop: false);
		}

		public bool TryAddSpecific(CandyKindID kind)
		{
			if (Candies.Count >= 6)
			{
				return false;
			}
			Candies.Add(kind);
			return true;
		}

		public CandyKindID TryRemove(int index)
		{
			if (index < 0 || index > Candies.Count)
			{
				return CandyKindID.None;
			}
			CandyKindID result = Candies[index];
			Candies.RemoveAt(index);
			ServerRefreshBag();
			return result;
		}

		public bool CompareIdentical(ItemBase ib)
		{
			if (!(ib is Scp330Bag scp330Bag))
			{
				return false;
			}
			if (Candies.Count != scp330Bag.Candies.Count)
			{
				return false;
			}
			for (int i = 0; i < Candies.Count; i++)
			{
				if (Candies[i] != scp330Bag.Candies[i])
				{
					return false;
				}
			}
			return true;
		}

		public static bool ServerProcessPickup(ReferenceHub ply, Scp330Pickup pickup, out Scp330Bag bag)
		{
			if (!TryGetBag(ply, out bag))
			{
				int num = ((!(pickup == null)) ? pickup.Info.Serial : 0);
				return ply.inventory.ServerAddItem(ItemType.SCP330, ItemAddReason.Scp914Upgrade, (ushort)num, pickup) != null;
			}
			bool result = false;
			if (pickup == null)
			{
				result = bag.TryAddSpecific(Scp330Candies.GetRandom());
			}
			else
			{
				while (pickup.StoredCandies.Count > 0 && bag.TryAddSpecific(pickup.StoredCandies[0]))
				{
					result = true;
					pickup.StoredCandies.RemoveAt(0);
				}
			}
			bag.ServerRefreshBag();
			return result;
		}

		public static bool TryAddCandy(ReferenceHub hub, CandyKindID kind)
		{
			if (!TryGetBag(hub, out var bag))
			{
				bag = (Scp330Bag)hub.inventory.ServerAddItem(ItemType.SCP330, ItemAddReason.Scp914Upgrade, 0);
				if (bag == null)
				{
					return false;
				}
				bag.Candies.Clear();
			}
			bool result = bag.TryAddSpecific(kind);
			bag.ServerRefreshBag();
			return result;
		}

		public static bool CanAddCandy(ReferenceHub hub)
		{
			if (!TryGetBag(hub, out var bag))
			{
				return hub.inventory.UserInventory.Items.Count < 8;
			}
			return bag.Candies.Count < 6;
		}

		public static bool TryGetBag(ReferenceHub hub, out Scp330Bag bag)
		{
			bag = null;
			bool result = false;
			foreach (KeyValuePair<ushort, ItemBase> item in hub.inventory.UserInventory.Items)
			{
				if (item.Value is Scp330Bag scp330Bag)
				{
					bag = scp330Bag;
					result = true;
					if (scp330Bag.Candies.Count > 0)
					{
						return true;
					}
				}
			}
			return result;
		}

		public static void AddSimpleRegeneration(ReferenceHub hub, float rate, float duration)
		{
			AnimationCurve regenCurve = AnimationCurve.Constant(0f, duration, rate);
			UsableItemsController.GetHandler(hub).ActiveRegenerations.Add(new RegenerationProcess(regenCurve, 1f, 1f));
		}

		private void SendClientMessage(int candyIdex, bool drop)
		{
			NetworkClient.Send(new SelectScp330Message
			{
				Serial = base.ItemSerial,
				CandyID = (byte)candyIdex,
				Drop = drop
			});
		}

		public void ServerRefreshBag()
		{
			if (Candies.Count > 0)
			{
				base.OwnerInventory.connectionToClient.Send(new SyncScp330Message
				{
					Serial = base.ItemSerial,
					Candies = Candies
				});
			}
			else
			{
				ServerRemoveSelf();
			}
		}

		internal override void RegisterSpawnablePrefabs(HashSet<GameObject> alreadyRegistered)
		{
			base.RegisterSpawnablePrefabs(alreadyRegistered);
			GameObject gameObject = TantrumPrefab.gameObject;
			if (alreadyRegistered.Add(gameObject))
			{
				NetworkClient.RegisterPrefab(gameObject);
			}
		}

		public override void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			if (!base.IsEquipped)
			{
				return;
			}
			for (int i = 0; i < Candies.Count; i++)
			{
				int copyI = i;
				actionAdder(new DummyAction(string.Format("{0}->Eat_{1}_{2}", "Scp330Bag", i, Candies[i]), () =>
				{
					this.ServerSelectCandy(copyI);
				}));
			}
			for (int num = 0; num < Candies.Count; num++)
			{
				int copyI2 = num;
				actionAdder(new DummyAction(string.Format("{0}->Drop_{1}_{2}", "Scp330Bag", num, Candies[num]), () =>
				{
					this.ServerDropCandy(copyI2);
				}));
			}
		}
	}
}
