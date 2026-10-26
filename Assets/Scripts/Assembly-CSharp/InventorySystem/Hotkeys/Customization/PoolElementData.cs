namespace InventorySystem.Hotkeys.Customization
{
	[global::System.Serializable]
	public struct PoolElementData : global::System.IEquatable<global::InventorySystem.Hotkeys.Customization.PoolElementData>
	{
		public enum ElementType
		{
			SpecificItem = 0,
			Group = 1,
			Order = 2
		}

		[global::UnityEngine.SerializeField]
		private short _value;

		public global::InventorySystem.Hotkeys.Customization.PoolElementData.ElementType Type;

		public readonly ItemType SpecificItem
		{
			get
			{
				return default;
			}
		}

		public readonly global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup Group
		{
			get
			{
				return default;
			}
		}

		public readonly int Order
		{
			get
			{
				return default;
			}
		}

		private readonly void EnsureType(global::InventorySystem.Hotkeys.Customization.PoolElementData.ElementType received)
		{
		}

		public readonly bool Equals(global::InventorySystem.Hotkeys.Customization.PoolElementData other)
		{
			return default;
		}

		public readonly void Serialize(global::Mirror.NetworkWriter writer)
		{
		}

		public PoolElementData(global::Mirror.NetworkReader reader)
		{ this = default;
		}

		public PoolElementData(global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup group)
		{ this = default;
		}

		public PoolElementData(ItemType item)
		{ this = default;
		}

		public PoolElementData(int order)
		{ this = default;
		}
	}
}
