using Mirror;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class AdminFlagsStat : SyncedStatBase
	{
		private float _maxValue;

		public override SyncMode Mode => SyncMode.Public;

		public override float MinValue => 0f;

		public override float MaxValue
		{
			get
			{
				return _maxValue;
			}
			set
			{
				_maxValue = value;
			}
		}

		public AdminFlags Flags
		{
			get
			{
				return (AdminFlags)Mathf.RoundToInt(CurValue);
			}
			set
			{
				CurValue = (float)value;
			}
		}

		public bool HasFlag(AdminFlags flag)
		{
			return (flag & Flags) == flag;
		}

		public void InvertFlag(AdminFlags flag)
		{
			AdminFlags flags = Flags;
			Flags = (((flag & flags) != flag) ? (flags | flag) : (flags & ~flag));
		}

		public void SetFlag(AdminFlags flag, bool status)
		{
			Flags = (status ? (Flags | flag) : (Flags & ~flag));
		}

		public override float ReadValue(SyncedStatMessages.StatMessageType type, NetworkReader reader)
		{
			return (int)reader.ReadByte();
		}

		public override void WriteValue(SyncedStatMessages.StatMessageType type, NetworkWriter writer)
		{
			byte value = ((type == SyncedStatMessages.StatMessageType.CurrentValue) ? ((byte)Flags) : ((byte)MaxValue));
			writer.WriteByte(value);
		}

		public override bool CheckDirty(float prevValue, float newValue)
		{
			return (int)prevValue != (int)newValue;
		}
	}
}
