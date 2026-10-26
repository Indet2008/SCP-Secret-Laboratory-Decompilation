using System.Collections.Generic;
using InventorySystem.Items;
using UnityEngine;

namespace MapGeneration
{
	public class InitiallySpawnedItems : MonoBehaviour
	{
		private HashSet<ushort> _initiallySpawnedItemSerials = new HashSet<ushort>();

		public static InitiallySpawnedItems Singleton;

		private void Awake()
		{
			Singleton = this;
		}

		public bool IsInitiallySpawned(ushort _itemSerial)
		{
			return _initiallySpawnedItemSerials.Contains(_itemSerial);
		}

		public bool IsInitiallySpawned(ItemIdentifier _item)
		{
			return IsInitiallySpawned(_item.SerialNumber);
		}

		public void AddInitial(ushort _itemSerial)
		{
			_initiallySpawnedItemSerials.Add(_itemSerial);
		}

		public void AddInitial(ItemIdentifier _item)
		{
			AddInitial(_item.SerialNumber);
		}

		public void RemoveInitial(ushort _itemSerial)
		{
			_initiallySpawnedItemSerials.Remove(_itemSerial);
		}

		public void RemoveInitial(ItemIdentifier _item)
		{
			RemoveInitial(_item.SerialNumber);
		}

		public void ClearAll()
		{
			_initiallySpawnedItemSerials.Clear();
		}
	}
}
