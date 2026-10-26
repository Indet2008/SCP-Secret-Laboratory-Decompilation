using Mirror;
using PlayerRoles.PlayableScps.HumeShield;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class HumeShieldStat : SyncedStatBase
	{
		private float _syncMax;

		private bool _maxValueOverride;

		public override SyncMode Mode => SyncMode.PrivateAndSpectators;

		public override float MinValue => 0f;

		public override float MaxValue
		{
			get
			{
				return _syncMax;
			}
			set
			{
				_syncMax = value;
				_maxValueOverride = value >= 0f;
				MaxValueDirty = true;
			}
		}

		public override float CurValue
		{
			get
			{
				return base.CurValue;
			}
			set
			{
				base.CurValue = Mathf.Max(0f, value);
			}
		}

		public override bool CheckDirty(float prevValue, float newValue)
		{
			return Mathf.CeilToInt(prevValue) != Mathf.CeilToInt(newValue);
		}

		public override float ReadValue(SyncedStatMessages.StatMessageType type, NetworkReader reader)
		{
			if (type != SyncedStatMessages.StatMessageType.CurrentValue)
			{
				return reader.ReadFloat();
			}
			return (int)reader.ReadUShort();
		}

		public override void WriteValue(SyncedStatMessages.StatMessageType type, NetworkWriter writer)
		{
			switch (type)
			{
			case SyncedStatMessages.StatMessageType.CurrentValue:
			{
				int num = Mathf.Clamp(Mathf.CeilToInt(CurValue), 0, 65535);
				writer.WriteUShort((ushort)num);
				break;
			}
			case SyncedStatMessages.StatMessageType.MaxValue:
				writer.WriteFloat(MaxValue);
				break;
			}
		}

		internal override void Update()
		{
			base.Update();
			if (!NetworkServer.active)
			{
				return;
			}
			IHumeShieldProvider.GetForHub(base.Hub, out var _, out var hsMax, out var hsRegen, out var _);
			float curValue = CurValue;
			float num = hsRegen * Time.deltaTime;
			if (_syncMax != hsMax)
			{
				if (_maxValueOverride)
				{
					hsMax = MaxValue;
				}
				else
				{
					_syncMax = hsMax;
					MaxValueDirty = true;
				}
			}
			if (num > 0f)
			{
				if (!(curValue >= hsMax))
				{
					CurValue = Mathf.MoveTowards(curValue, hsMax, num);
				}
			}
			else if (!(curValue <= 0f))
			{
				CurValue = curValue + num;
			}
		}

		internal override void ClassChanged()
		{
			base.ClassChanged();
			if (!(base.Hub.roleManager.CurrentRole is IHumeShieldedRole))
			{
				MaxValue = float.MinValue;
				CurValue = 0f;
			}
		}

		protected override void OnValueChanged(float prevValue, float newValue)
		{
			if (base.Hub.roleManager.CurrentRole is IHumeShieldedRole humeShieldedRole)
			{
				humeShieldedRole.HumeShieldModule.OnHsValueChanged(prevValue, newValue);
			}
		}
	}
}
