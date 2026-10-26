using System;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.ThrowableProjectiles;
using Mirror;
using UnityEngine;

namespace Scp914.Processors
{
	public class Scp2176ItemProcessor : StandardItemProcessor
	{
		private const float NumOfCoins = 12f;

		private const float NumOfFlashlights = 1f;

		private const float FlashlightChance = 0.2f;

		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			if (!(sourcePickup is Scp2176Projectile scp2176Projectile))
			{
				throw new InvalidOperationException(string.Format("Attempted to use {0} on item with type {1}", "Scp2176ItemProcessor", sourcePickup.Info.ItemId));
			}
			ClearCombiner();
			switch (setting)
			{
			case Scp914KnobSetting.Rough:
				scp2176Projectile.ServerImmediatelyShatter();
				break;
			case Scp914KnobSetting.OneToOne:
			{
				for (int j = 0; (float)j < 12f; j++)
				{
					SpawnItem(ItemType.Coin, sourcePickup);
				}
				sourcePickup.DestroySelf();
				break;
			}
			case Scp914KnobSetting.VeryFine:
				if (!(UnityEngine.Random.value < 0.2f))
				{
					for (int i = 0; (float)i < 1f; i++)
					{
						SpawnItem(ItemType.Flashlight, sourcePickup);
					}
					sourcePickup.DestroySelf();
				}
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
