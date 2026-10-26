using System;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using Mirror;

namespace Scp914.Processors
{
	public class Scp1344ItemProcessor : StandardItemProcessor
	{
		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			if (sourcePickup.Info.ItemId != ItemType.SCP1344)
			{
				throw new InvalidOperationException(string.Format("Attempted to use {0} on item with type {1}", "Scp1344ItemProcessor", sourcePickup.Info.ItemId));
			}
			ClearCombiner();
			switch (setting)
			{
			case Scp914KnobSetting.OneToOne:
				SpawnItem(ItemType.GrenadeFlash, sourcePickup);
				SpawnItem(ItemType.Adrenaline, sourcePickup);
				sourcePickup.DestroySelf();
				break;
			case Scp914KnobSetting.VeryFine:
				SpawnItem(ItemType.Adrenaline, sourcePickup);
				SpawnItem(ItemType.Adrenaline, sourcePickup);
				SpawnItem(ItemType.SCP2176, sourcePickup);
				sourcePickup.DestroySelf();
				break;
			default:
				return base.UpgradePickup(setting, sourcePickup);
			}
			return GenerateResultFromCombiner(sourcePickup);
		}

		private void SpawnItem(ItemType itemType, ItemPickupBase sourcePickup)
		{
			if (InventoryItemLoader.AvailableItems.TryGetValue(itemType, out var value))
			{
				PickupSyncInfo value2 = new PickupSyncInfo
				{
					ItemId = itemType,
					Serial = ItemSerialGenerator.GenerateNext(),
					WeightKg = value.Weight
				};
				bool spawn = NetworkServer.spawned.ContainsKey(sourcePickup.netId);
				ItemPickupBase resultingPickup = InventoryExtensions.ServerCreatePickup(value, value2, sourcePickup.Position + Scp914Controller.MoveVector, sourcePickup.Rotation, spawn);
				AddResultToCombiner(resultingPickup);
			}
		}
	}
}
