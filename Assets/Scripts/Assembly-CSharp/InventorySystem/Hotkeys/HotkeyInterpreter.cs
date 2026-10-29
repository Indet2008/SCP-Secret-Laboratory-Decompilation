using System;
using System.Collections.Generic;
using InventorySystem.GUI;
using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem.Hotkeys
{
	public static class HotkeyInterpreter
	{
		private class CachedResult
		{
			public ItemBase Item;

			public bool IsValid;
		}

		private static readonly List<ItemBase> UserItemsByOrder = new List<ItemBase>();

		private static readonly List<ItemBase> Matches = new List<ItemBase>();

		private static readonly List<int> OrderQueue = new List<int>();

		private static readonly List<KeyCode> KeyDuplicateChecker = new List<KeyCode>();

		private static CachedResult[] _cachedResults = new CachedResult[0];

		private static ReferenceHub _lastLocalPlayer;

		private static bool _allowChecks;

		private static bool _cacheSet;

		public static event Action OnHotkeysRevalidated;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += Update;
		}

		private static void Update()
		{
			if (!StaticUnityMethods.IsPlaying || !ReferenceHub.TryGetLocalHub(out _lastLocalPlayer))
			{
				return;
			}
			_cacheSet = false;
			KeyDuplicateChecker.Clear();
			UserItemsByOrder.Clear();
			if (InventoryGuiController.DisplayController is RadialInventory radialInventory)
			{
				Dictionary<ushort, ItemBase> items = _lastLocalPlayer.inventory.UserInventory.Items;
				ushort[] orderedItems = radialInventory.OrganizedContent;
				for (int i = 0; i < orderedItems.Length; i++)
				{
					if (items.TryGetValue(orderedItems[i], out var value))
					{
						UserItemsByOrder.Add(value);
					}
				}
			}
			_allowChecks = true;
			try
			{
				HotkeyInterpreter.OnHotkeysRevalidated?.Invoke();
			}
			finally
			{
				_allowChecks = false;
			}
		}

		private static bool CheckDuplicate(ItemBase ib, ItemBase other)
		{
			if (ib.ItemTypeId != other.ItemTypeId)
			{
				return false;
			}
			if (ib is IUniqueItem uniqueItem)
			{
				return uniqueItem.CompareIdentical(other);
			}
			return true;
		}

		private static bool TryGetOverride(int hotkeyIndex, out ItemBase overrideItem)
		{
			HotkeyOverrideOption overrideOption = HotkeyStorage.Hotkeys[hotkeyIndex].OverrideOption;
			overrideItem = null;
			HotkeyOverrideBase[] overrides = HotkeyOverrideBase.Overrides;
			foreach (HotkeyOverrideBase hotkeyOverrideBase in overrides)
			{
				if (hotkeyOverrideBase.OptionType == overrideOption && hotkeyOverrideBase.TryGetOverride(_lastLocalPlayer, hotkeyIndex, Matches, out var result))
				{
					overrideItem = result;
					return true;
				}
			}
			return false;
		}

		private static void AddMatchIfUnique(ItemBase ib)
		{
			foreach (ItemBase match in Matches)
			{
				if (CheckDuplicate(ib, match))
				{
					return;
				}
			}
			Matches.Add(ib);
		}

		private static void SelectFromMatches(int hotkeyIndex, CachedResult result)
		{
			if (Matches.Count == 0)
			{
				result.IsValid = false;
				return;
			}
			ItemBase curInstance = _lastLocalPlayer.inventory.CurInstance;
			ItemBase item = null;
			if (curInstance != null)
			{
				for (int i = 0; i < Matches.Count; i++)
				{
					if (CheckDuplicate(curInstance, Matches[i]))
					{
						item = Matches[(i + 1) % Matches.Count];
						break;
					}
				}
			}
			if (item == null && !TryGetOverride(hotkeyIndex, out item))
			{
				item = Matches[0];
			}
			result.Item = item;
			result.IsValid = true;
		}

		private static void UpdateCacheForItemQueue(int hotkeyIndex)
		{
			CachedResult result = _cachedResults[hotkeyIndex];
			Matches.Clear();
			ItemType[] itemsByQueue = HotkeyUtils.GetItemsByQueue(hotkeyIndex);
			foreach (ItemType itemType in itemsByQueue)
			{
				foreach (ItemBase item in UserItemsByOrder)
				{
					if (item.ItemTypeId == itemType)
					{
						AddMatchIfUnique(item);
					}
				}
			}
			SelectFromMatches(hotkeyIndex, result);
		}

		private static void UpdateCacheForInventoryOrder(int hotkeyIndex)
		{
			PoolElementData[] elements = HotkeyStorage.Hotkeys[hotkeyIndex].Elements;
			CachedResult result = _cachedResults[hotkeyIndex];
			Matches.Clear();
			OrderQueue.Clear();
			List<ItemType> list = ListPool<ItemType>.Shared.Rent();
			foreach (PoolElementData poolElementData in elements)
			{
				switch (poolElementData.Type)
				{
				case PoolElementData.ElementType.Order:
					OrderQueue.Add(poolElementData.Order);
					break;
				case PoolElementData.ElementType.Group:
					list.AddRange(poolElementData.Group.GetItems());
					break;
				case PoolElementData.ElementType.SpecificItem:
					list.Add(poolElementData.SpecificItem);
					break;
				}
			}
			List<ItemBase> list2 = ListPool<ItemBase>.Shared.Rent();
			foreach (ItemBase item in UserItemsByOrder)
			{
				if (!list.Contains(item.ItemTypeId))
				{
					continue;
				}
				bool flag = false;
				foreach (ItemBase item2 in list2)
				{
					if (CheckDuplicate(item, item2))
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					list2.Add(item);
				}
			}
			if (OrderQueue.Count == 0)
			{
				Matches.AddRange(list2);
			}
			else
			{
				foreach (int item3 in OrderQueue)
				{
					if (list2.TryGet(item3, out var element))
					{
						Matches.Add(element);
					}
				}
			}
			ListPool<ItemBase>.Shared.Return(list2);
			ListPool<ItemType>.Shared.Return(list);
			SelectFromMatches(hotkeyIndex, result);
		}

		private static void UpdateCacheForHotkey(int hotkeyIndex)
		{
			SavedHotkey savedHotkey = HotkeyStorage.Hotkeys[hotkeyIndex];
			KeyCode assignedKey = savedHotkey.AssignedKey;
			if (assignedKey != KeyCode.None && !KeyDuplicateChecker.Contains(assignedKey))
			{
				KeyDuplicateChecker.Add(assignedKey);
				switch (savedHotkey.SortMode)
				{
				case HotkeySortMode.ItemPoolOrder:
					UpdateCacheForItemQueue(hotkeyIndex);
					return;
				case HotkeySortMode.InventoryOrder:
					UpdateCacheForInventoryOrder(hotkeyIndex);
					return;
				}
			}
			_cachedResults[hotkeyIndex].IsValid = false;
		}

		public static bool TryGetItem(int hotkeyIndex, out ItemBase ib)
		{
			if (!_allowChecks)
			{
				throw new InvalidOperationException(string.Format("{0} cannot be called outside the {1} event!", "TryGetItem", "OnHotkeysRevalidated"));
			}
			if (!_cacheSet)
			{
				int count = HotkeyStorage.Hotkeys.Count;
				if (_cachedResults.Length < count)
				{
					_cachedResults = new CachedResult[count];
				}
				for (int i = 0; i < count; i++)
				{
					if (_cachedResults[i] == null)
					{
						_cachedResults[i] = new CachedResult();
					}
					UpdateCacheForHotkey(i);
				}
				_cacheSet = true;
			}
			CachedResult cachedResult = _cachedResults[hotkeyIndex];
			ib = cachedResult.Item;
			return cachedResult.IsValid;
		}
	}
}
