using System.Collections.Generic;
using GameObjectPools;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	public static class ThirdpersonItemPoolManager
	{
		private static bool _poolsInitiated;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += SetupPools;
		}

		private static void SetupPools()
		{
			if (_poolsInitiated)
			{
				return;
			}
			foreach (KeyValuePair<ItemType, ItemBase> availableItem in InventoryItemLoader.AvailableItems)
			{
				PoolObject thirdpersonModel = availableItem.Value.ThirdpersonModel;
				if (thirdpersonModel != null)
				{
					PoolManager.Singleton.TryAddPool(thirdpersonModel);
				}
			}
			_poolsInitiated = true;
		}

		public static bool TryGet(InventorySubcontroller targetParent, ItemIdentifier item, out ThirdpersonItemBase result, bool restrictPoolingToItem = false)
		{
			if (restrictPoolingToItem)
			{
				if (!InventoryItemLoader.TryGetItem<ItemBase>(item.TypeId, out var result2) || result2.ThirdpersonModel == null)
				{
					result = null;
					return false;
				}
				PoolManager.Singleton.TryAddPool(result2.ThirdpersonModel);
			}
			else
			{
				SetupPools();
			}
			result = null;
			if (targetParent.ItemSpawnpoint == null)
			{
				return false;
			}
			if (!InventoryItemLoader.AvailableItems.TryGetValue(item.TypeId, out var value))
			{
				return false;
			}
			if (value.ThirdpersonModel == null)
			{
				return false;
			}
			if (!PoolManager.Singleton.TryGetPoolObject(value.ThirdpersonModel.gameObject, out var poolObject, autoSetup: false))
			{
				return false;
			}
			result = poolObject as ThirdpersonItemBase;
			result.Initialize(targetParent, item);
			result.SetupPoolObject();
			return true;
		}
	}
}
