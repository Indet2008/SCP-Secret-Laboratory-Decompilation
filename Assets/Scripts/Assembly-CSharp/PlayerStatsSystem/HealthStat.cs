using Mirror;
using PlayerRoles;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class HealthStat : SyncedStatBase
	{
		private float _maxValue;

		public override SyncMode Mode => SyncMode.PrivateAndSpectators;

		public override float MinValue => 0f;

		public override float MaxValue
		{
			get
			{
				return _maxValue;
			}
			set
			{
				if (value != _maxValue)
				{
					_maxValue = value;
					MaxValueDirty = true;
					CurValue = Mathf.Min(CurValue, _maxValue);
				}
			}
		}

		public bool FullyHealed => CurValue >= MaxValue;

		public override float ReadValue(SyncedStatMessages.StatMessageType type, NetworkReader reader)
		{
			return (int)reader.ReadUShort();
		}

		public override void WriteValue(SyncedStatMessages.StatMessageType type, NetworkWriter writer)
		{
			int num = ((type == SyncedStatMessages.StatMessageType.CurrentValue) ? Mathf.Clamp(Mathf.CeilToInt(CurValue), 0, 65535) : Mathf.Clamp(Mathf.CeilToInt(MaxValue), 0, 65535));
			writer.WriteUShort((ushort)num);
		}

		public override bool CheckDirty(float prevValue, float newValue)
		{
			return Mathf.CeilToInt(prevValue) != Mathf.CeilToInt(newValue);
		}

		internal override void ClassChanged()
		{
			base.ClassChanged();
			if (NetworkServer.active)
			{
				MaxValue = ((base.Hub.roleManager.CurrentRole is IHealthbarRole healthbarRole) ? healthbarRole.MaxHealth : 0f);
				CurValue = MaxValue;
			}
		}

		public void ServerHeal(float healAmount)
		{
			CurValue = Mathf.Min(CurValue + Mathf.Abs(healAmount), MaxValue);
		}
	}
}
