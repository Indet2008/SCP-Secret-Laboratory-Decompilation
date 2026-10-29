using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	[Serializable]
	public struct PoolElementData : IEquatable<PoolElementData>
	{
		public enum ElementType
		{
			SpecificItem = 0,
			Group = 1,
			Order = 2
		}

		[SerializeField]
		private short _value;

		public ElementType Type;

		public readonly ItemType SpecificItem
		{
			get
			{
				EnsureType(ElementType.SpecificItem);
				return (ItemType)_value;
			}
		}

		public readonly HotkeyItemGroup Group
		{
			get
			{
				EnsureType(ElementType.Group);
				return (HotkeyItemGroup)_value;
			}
		}

		public readonly int Order
		{
			get
			{
				EnsureType(ElementType.Order);
				return _value;
			}
		}

		private readonly void EnsureType(ElementType received)
		{
			if (received != Type)
			{
				throw new InvalidCastException(string.Format("Invalid to access value as {0}, stored queue element is a {1}", received, Type));
			}
		}

		public readonly bool Equals(PoolElementData other)
		{
			if (_value == other._value)
			{
				return Type == other.Type;
			}
			return false;
		}

		public readonly void Serialize(NetworkWriter writer)
		{
			writer.WriteByte((byte)Type);
			writer.WriteShort(_value);
		}

		public PoolElementData(NetworkReader reader)
		{
			Type = (ElementType)reader.ReadByte();
			_value = reader.ReadShort();
		}

		public PoolElementData(HotkeyItemGroup group)
		{
			Type = ElementType.Group;
			_value = (short)group;
		}

		public PoolElementData(ItemType item)
		{
			Type = ElementType.SpecificItem;
			_value = (short)item;
		}

		public PoolElementData(int order)
		{
			Type = ElementType.Order;
			_value = (short)order;
		}
	}
}
