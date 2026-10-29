using System.Collections.Generic;
using InventorySystem.Items;
using InventorySystem.Items.Armor;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Usables.Scp330;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyUtils
	{
		private static readonly Dictionary<int, ItemType[]> ItemOrder = new Dictionary<int, ItemType[]>();

		public static ItemType[] GetItemsByQueue(int hotkeyIndex)
		{
			if (!ItemOrder.TryGetValue(hotkeyIndex, out var value))
			{
				value = HotkeyStorage.Hotkeys[hotkeyIndex].Elements.GetItemsByQueue();
				ItemOrder.Add(hotkeyIndex, value);
			}
			return value;
		}

		public static ItemType[] GetItemsByQueue(this IEnumerable<PoolElementData> elements)
		{
			List<ItemType> list = ListPool<ItemType>.Shared.Rent();
			elements.GetItemsByQueue(list);
			ItemType[] result = list.ToArray();
			ListPool<ItemType>.Shared.Return(list);
			return result;
		}

		public static void GetItemsByQueue(this IEnumerable<PoolElementData> elements, List<ItemType> targetList)
		{
			foreach (PoolElementData element in elements)
			{
				switch (element.Type)
				{
				case PoolElementData.ElementType.SpecificItem:
					AddToList(element.SpecificItem);
					break;
				case PoolElementData.ElementType.Group:
				{
					ItemType[] items = element.Group.GetItems();
					for (int i = 0; i < items.Length; i++)
					{
						AddToList(items[i]);
					}
					break;
				}
				}
			}
			void AddToList(ItemType it)
			{
				if (!targetList.Contains(it))
				{
					targetList.Add(it);
				}
			}
		}

		public static int CountMatches(this List<PoolElementData> elements, ItemType[] filters)
		{
			List<ItemType> list = ListPool<ItemType>.Shared.Rent();
			elements.GetItemsByQueue(list);
			int num = 0;
			foreach (ItemType item in list)
			{
				if (System.Array.IndexOf(filters, item) >= 0)
				{
					num++;
				}
			}
			ListPool<ItemType>.Shared.Return(list);
			return num;
		}

		public static bool IsHotkeyable(this ItemBase item)
		{
			if (item is IItemNametag && !(item is AmmoItem) && !(item is BodyArmor))
			{
				return !(item is Scp330Bag);
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			HotkeyStorage.OnHotkeysSaved += ItemOrder.Clear;
		}
	}
}
