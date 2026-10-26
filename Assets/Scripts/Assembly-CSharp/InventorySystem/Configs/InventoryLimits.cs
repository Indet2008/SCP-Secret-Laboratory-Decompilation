using System.Collections.Generic;
using InventorySystem.Items.Armor;
using UnityEngine;

namespace InventorySystem.Configs
{
	public static class InventoryLimits
	{
		public static readonly Dictionary<ItemType, ushort> StandardAmmoLimits = new Dictionary<ItemType, ushort>
		{
			[ItemType.Ammo9x19] = 40,
			[ItemType.Ammo556x45] = 40,
			[ItemType.Ammo762x39] = 40,
			[ItemType.Ammo44cal] = 18,
			[ItemType.Ammo12gauge] = 14
		};

		public static readonly Dictionary<ItemCategory, sbyte> StandardCategoryLimits = new Dictionary<ItemCategory, sbyte>
		{
			[ItemCategory.Armor] = -1,
			[ItemCategory.Grenade] = 2,
			[ItemCategory.Keycard] = 3,
			[ItemCategory.Medical] = 3,
			[ItemCategory.SpecialWeapon] = -1,
			[ItemCategory.Radio] = -1,
			[ItemCategory.SCPItem] = 3,
			[ItemCategory.Firearm] = 1
		};

		private static ServerConfigSynchronizer Config => ServerConfigSynchronizer.Singleton;

		public static ushort GetAmmoLimit(ItemType ammoType, ReferenceHub player)
		{
			BodyArmor bodyArmor;
			return GetAmmoLimit((player != null && player.inventory.TryGetBodyArmor(out bodyArmor)) ? bodyArmor : null, ammoType);
		}

		public static sbyte GetCategoryLimit(ItemCategory category, ReferenceHub player)
		{
			BodyArmor bodyArmor;
			return GetCategoryLimit((player != null && player.inventory.TryGetBodyArmor(out bodyArmor)) ? bodyArmor : null, category);
		}

		public static ushort GetAmmoLimit(BodyArmor armor, ItemType ammoType)
		{
			int num = -1;
			foreach (ServerConfigSynchronizer.AmmoLimit item in Config.AmmoLimitsSync)
			{
				if (item.AmmoType == ammoType)
				{
					if (item.Limit == 0)
					{
						return ushort.MaxValue;
					}
					num = item.Limit;
					break;
				}
			}
			if (num == -1)
			{
				if (!StandardAmmoLimits.TryGetValue(ammoType, out var value))
				{
					return ushort.MaxValue;
				}
				num = value;
			}
			if (armor != null)
			{
				BodyArmor.ArmorAmmoLimit[] ammoLimits = armor.AmmoLimits;
				for (int i = 0; i < ammoLimits.Length; i++)
				{
					BodyArmor.ArmorAmmoLimit armorAmmoLimit = ammoLimits[i];
					if (armorAmmoLimit.AmmoType == ammoType)
					{
						num += armorAmmoLimit.Limit;
						break;
					}
				}
			}
			return (ushort)Mathf.Min(65535, num);
		}

		public static sbyte GetCategoryLimit(BodyArmor armor, ItemCategory category)
		{
			int num;
			if ((int)category < Config.CategoryLimits.Count)
			{
				num = Config.CategoryLimits[(int)category];
			}
			else
			{
				if (!StandardCategoryLimits.TryGetValue(category, out var value))
				{
					return sbyte.MaxValue;
				}
				num = value;
			}
			if (armor != null)
			{
				BodyArmor.ArmorCategoryLimitModifier[] categoryLimits = armor.CategoryLimits;
				for (int i = 0; i < categoryLimits.Length; i++)
				{
					BodyArmor.ArmorCategoryLimitModifier armorCategoryLimitModifier = categoryLimits[i];
					if (armorCategoryLimitModifier.Category == category)
					{
						num += armorCategoryLimitModifier.Limit;
						break;
					}
				}
			}
			return (sbyte)Mathf.Clamp(num, -8, 8);
		}
	}
}
