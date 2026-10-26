using System;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace Scp914.Processors
{
	public class AmmoItemProcessor : Scp914ItemProcessor
	{
		[SerializeField]
		private ItemType _previousAmmo;

		[SerializeField]
		private ItemType _oneToOne;

		[SerializeField]
		private ItemType _nextAmmo;

		public override Scp914Result UpgradeInventoryItem(Scp914KnobSetting setting, ItemBase ib)
		{
			return new Scp914Result(ib, ib, null);
		}

		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			if (!(sourcePickup is AmmoPickup ammoPickup))
			{
				throw new InvalidOperationException(string.Format("Attempted to use {0} on item with type {1}", "AmmoItemProcessor", sourcePickup.Info.ItemId));
			}
			ItemType itemType;
			switch (setting)
			{
			case Scp914KnobSetting.Rough:
			case Scp914KnobSetting.Coarse:
				itemType = _previousAmmo;
				break;
			case Scp914KnobSetting.OneToOne:
				itemType = _oneToOne;
				break;
			case Scp914KnobSetting.Fine:
			case Scp914KnobSetting.VeryFine:
				itemType = _nextAmmo;
				break;
			default:
				throw new InvalidOperationException("Undefined knob setting: " + setting);
			}
			sourcePickup.Position += Scp914Controller.MoveVector;
			ExchangeAmmo(ammoPickup.Info.ItemId, itemType, ammoPickup.SavedAmmo, out var exchangedAmmo, out var change);
			if (change == 0)
			{
				ammoPickup.DestroySelf();
			}
			else
			{
				ammoPickup.NetworkSavedAmmo = (ushort)change;
			}
			ItemPickupBase resultingPickup = CreateAmmoPickup(itemType, exchangedAmmo, sourcePickup.Position);
			return new Scp914Result(sourcePickup, null, resultingPickup);
		}

		public static ItemPickupBase CreateAmmoPickup(ItemType type, int bullets, Vector3 pos)
		{
			if (bullets <= 0 || !InventoryItemLoader.AvailableItems.TryGetValue(type, out var value))
			{
				return null;
			}
			PickupSyncInfo value2 = new PickupSyncInfo
			{
				ItemId = type,
				Serial = ItemSerialGenerator.GenerateNext(),
				WeightKg = value.Weight
			};
			if (InventoryExtensions.ServerCreatePickup(value, value2, pos) is AmmoPickup ammoPickup)
			{
				ammoPickup.NetworkSavedAmmo = (ushort)bullets;
				return ammoPickup;
			}
			return null;
		}

		public static void ExchangeAmmo(ItemType ammoTypeToExchange, ItemType targetAmmoType, int amount, out int exchangedAmmo, out int change)
		{
			if (!ammoTypeToExchange.TryGetTemplate<AmmoItem>(out var item) || !targetAmmoType.TryGetTemplate<AmmoItem>(out var item2))
			{
				exchangedAmmo = 0;
				change = amount;
				return;
			}
			int unitPrice = item.UnitPrice;
			int unitPrice2 = item2.UnitPrice;
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			for (int i = 0; i < amount; i++)
			{
				num3 += unitPrice;
				num++;
				if (num3 % unitPrice2 == 0)
				{
					num2 += num3 / unitPrice2;
					num = 0;
					num3 = 0;
				}
			}
			exchangedAmmo = num2;
			change = num;
		}
	}
}
