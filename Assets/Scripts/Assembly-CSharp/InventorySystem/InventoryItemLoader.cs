using System;
using System.Collections.Generic;
using FastResources;
using InventorySystem.Items;
using UnityEngine;

namespace InventorySystem
{
	public static class InventoryItemLoader
	{
		private static Dictionary<ItemType, ItemBase> _loadedItems = new Dictionary<ItemType, ItemBase>();

		private static readonly HashSet<GameObject> AlreadyRegisteredNonAlloc = new HashSet<GameObject>();

		private static bool _loaded;

		public static Dictionary<ItemType, ItemBase> AvailableItems
		{
			get
			{
				if (!_loaded)
				{
					ForceReload();
				}
				return _loadedItems;
			}
		}

		public static bool TryGetItem<T>(ItemType itemType, out T result) where T : ItemBase
		{
			if (!AvailableItems.TryGetValue(itemType, out var value) || !(value is T val))
			{
				result = null;
				return false;
			}
			result = val;
			return true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += RegisterPrefabs;
		}

		private static void RegisterPrefabs()
		{
			AlreadyRegisteredNonAlloc.Clear();
			foreach (ItemBase value in AvailableItems.Values)
			{
				value.RegisterSpawnablePrefabs(AlreadyRegisteredNonAlloc);
			}
			Debug.Log("Successfully registered " + AlreadyRegisteredNonAlloc.Count + " spawnable prefabs for " + AvailableItems.Count + " items.");
		}

		public static void ForceReload()
		{
			ItemType itemType = ItemType.None;
			try
			{
				_loadedItems = new Dictionary<ItemType, ItemBase>();
				ItemBase[] array = FastResourcesDatabase.GetAll<ItemBase>().ToArray();
				Array.Sort(array, (ItemBase x, ItemBase y) =>
				{
					int itemTypeId = (int)x.ItemTypeId;
					return itemTypeId.CompareTo((int)y.ItemTypeId);
				});
				for (int num = 0; num < array.Length; num++)
				{
					ItemBase itemBase = array[num];
					// Local change: in the Unity editor, holiday items are loaded outside their event too, so the RA panel lists them.
					if ((!(itemBase is IHolidayItem { IsAvailable: false }) || Application.isEditor) && itemBase.ItemTypeId != ItemType.None)
					{
						if (itemBase.VariantsModule != null && itemBase.VariantsModule.TryGetVariant(out var variant))
						{
							itemBase = variant;
						}
						itemType = itemBase.ItemTypeId;
						if (_loadedItems.TryAdd(itemBase.ItemTypeId, itemBase))
						{
							itemBase.OnTemplateReloaded(_loaded);
						}
						else
						{
							Debug.LogError("Error while loading items: " + itemType.ToString() + " is duplicate.");
						}
					}
				}
				_loaded = true;
			}
			catch (Exception exception)
			{
				Debug.LogError("Error while loading items from the resources folder. Last assigned item: " + itemType);
				Debug.LogException(exception);
				_loaded = false;
			}
		}
	}
}
