using System;
using System.Collections.Generic;
using System.Linq;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Keycards;
using InventorySystem.Items.ThrowableProjectiles;

namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyItemGroupDefinitions
	{
		private static readonly Dictionary<HotkeyItemGroup, CachedValue<ItemType[]>> Groups = new Dictionary<HotkeyItemGroup, CachedValue<ItemType[]>>
		{
			[HotkeyItemGroup.AnyFirearm] = new CachedValue<ItemType[]>(AnyFirearm),
			[HotkeyItemGroup.AnyKeycard] = new CachedValue<ItemType[]>(AnyKeycard),
			[HotkeyItemGroup.AnyThrowable] = new CachedValue<ItemType[]>(() => ItemsOfTypeOrdered((ThrowableItem x) => x.Weight)),
			[HotkeyItemGroup.AnyScpItem] = new CachedValue<ItemType[]>(() => FromCategory(ItemCategory.SCPItem))
		};

		private static readonly Dictionary<HotkeyItemGroup, HotkeysTranslation> GroupToTranslation = new Dictionary<HotkeyItemGroup, HotkeysTranslation>
		{
			[HotkeyItemGroup.AnyFirearm] = HotkeysTranslation.GroupFirearms,
			[HotkeyItemGroup.AnyKeycard] = HotkeysTranslation.GroupKeycards,
			[HotkeyItemGroup.AnyThrowable] = HotkeysTranslation.GroupThrowable,
			[HotkeyItemGroup.AnyScpItem] = HotkeysTranslation.GroupScpItems
		};

		private static readonly CachedValue<ItemType[]> EmptyFallback = new CachedValue<ItemType[]>(() => new ItemType[0]);

		public static ItemType[] GetItems(this HotkeyItemGroup group)
		{
			if (!Groups.TryGetValue(group, out var value))
			{
				value = EmptyFallback;
			}
			return value.Value;
		}

		public static string GetTranslation(this HotkeyItemGroup group)
		{
			if (!GroupToTranslation.TryGetValue(group, out var value))
			{
				return group.ToString();
			}
			return Translations.Get(value);
		}

		private static ItemType[] AnyFirearm()
		{
			return ItemsOfTypeOrdered(delegate(Firearm x)
			{
				x.GetDefaultLengthAndWeight(out var length, out var weight);
				return length * weight;
			});
		}

		private static ItemType[] AnyKeycard()
		{
			DoorPermissionFlags[] allFlags = (DoorPermissionFlags[])Enum.GetValues(typeof(DoorPermissionFlags));
			return ItemsOfTypeOrdered(delegate(KeycardItem x)
			{
				int num = 0;
				DoorPermissionFlags permissions = x.GetPermissions(null);
				foreach (DoorPermissionFlags doorPermissionFlags in allFlags)
				{
					if (doorPermissionFlags != DoorPermissionFlags.None && (permissions & doorPermissionFlags) == doorPermissionFlags)
					{
						num++;
					}
				}
				return num;
			});
		}

		private static ItemType[] FromCategory(ItemCategory cat)
		{
			return (from x in InventoryItemLoader.AvailableItems.Values
				where x.Category == cat
				orderby x.Weight
				select x.ItemTypeId).ToArray();
		}

		private static ItemType[] ItemsOfTypeOrdered<TSource, TKey>(Func<TSource, TKey> keySelector) where TSource : ItemBase
		{
			return (from x in InventoryItemLoader.AvailableItems.Values.OfType<TSource>().OrderBy(keySelector)
				select x.ItemTypeId).ToArray();
		}
	}
}
