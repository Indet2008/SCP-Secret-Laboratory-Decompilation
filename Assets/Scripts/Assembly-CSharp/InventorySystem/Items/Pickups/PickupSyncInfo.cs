using System;

namespace InventorySystem.Items.Pickups
{
	[Serializable]
	public struct PickupSyncInfo : IEquatable<PickupSyncInfo>
	{
		[Flags]
		private enum PickupFlags : byte
		{
			Locked = 1,
			InUse = 2
		}

		public static PickupSyncInfo None = new PickupSyncInfo
		{
			ItemId = ItemType.None
		};

		public ItemType ItemId;

		public ushort Serial;

		public float WeightKg;

		private PickupFlags _flags;

		public byte SyncedFlags
		{
			get
			{
				return (byte)_flags;
			}
			set
			{
				_flags = (PickupFlags)value;
			}
		}

		public bool Locked
		{
			get
			{
				return (_flags & PickupFlags.Locked) == PickupFlags.Locked;
			}
			set
			{
				_flags = (value ? (_flags | PickupFlags.Locked) : (_flags & ~PickupFlags.Locked));
			}
		}

		public bool InUse
		{
			get
			{
				return (_flags & PickupFlags.InUse) == PickupFlags.InUse;
			}
			set
			{
				_flags = (value ? (_flags | PickupFlags.InUse) : (_flags & ~PickupFlags.InUse));
			}
		}

		public PickupSyncInfo(ItemType id, float weight, ushort serial = 0, bool locked = false)
		{
			ItemId = id;
			WeightKg = weight;
			_flags = (locked ? PickupFlags.Locked : ((PickupFlags)0));
			Serial = ((serial == 0) ? ItemSerialGenerator.GenerateNext() : serial);
		}

		public override int GetHashCode()
		{
			if (Serial == 0)
			{
				return ((int)ItemId * 397) ^ (int)_flags;
			}
			return Serial;
		}

		public static bool operator ==(PickupSyncInfo left, PickupSyncInfo right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(PickupSyncInfo left, PickupSyncInfo right)
		{
			return !left.Equals(right);
		}

		public bool Equals(PickupSyncInfo other)
		{
			if (ItemId == other.ItemId && WeightKg == other.WeightKg)
			{
				return _flags == other._flags;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is PickupSyncInfo other)
			{
				return Equals(other);
			}
			return false;
		}
	}
}
