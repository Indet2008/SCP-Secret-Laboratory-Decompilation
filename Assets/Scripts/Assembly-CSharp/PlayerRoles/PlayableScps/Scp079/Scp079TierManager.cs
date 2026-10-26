using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079TierManager : StandardSubroutine<Scp079Role>
	{
		private readonly struct ExpQueuedNotification
		{
			public readonly int ExpAmount;

			public readonly Scp079HudTranslation Reason;

			public readonly RoleTypeId Subject;

			public void Write(NetworkWriter writer)
			{
				writer.WriteUShort((ushort)ExpAmount);
				writer.WriteByte((byte)Reason);
				writer.WriteRoleType(Subject);
			}

			public ExpQueuedNotification(NetworkReader reader)
			{
				ExpAmount = reader.ReadUShort();
				Reason = (Scp079HudTranslation)reader.ReadByte();
				Subject = reader.ReadRoleType();
			}

			public ExpQueuedNotification(int amount, Scp079HudTranslation reason, RoleTypeId subject)
			{
				ExpAmount = Mathf.Clamp(amount, 0, 65535);
				Reason = reason;
				Subject = subject;
			}
		}

		private readonly Queue<ExpQueuedNotification> _expGainQueue = new Queue<ExpQueuedNotification>();

		private int _totalExp;

		private bool _valueDirty;

		private int _accessTier;

		private int _thresholdsCount;

		[SerializeField]
		private int[] _levelupThresholds;

		public Action OnLevelledUp;

		public Action OnTierChanged;

		public Action OnExpChanged;

		public int[] AbsoluteThresholds { get; private set; }

		public int TotalExp
		{
			get
			{
				return _totalExp;
			}
			set
			{
				_totalExp = value;
				OnExpChanged?.Invoke();
				int num = 0;
				for (int i = 0; i < _thresholdsCount && _totalExp >= AbsoluteThresholds[i]; i++)
				{
					num++;
				}
				AccessTierIndex = num;
				if (NetworkServer.active)
				{
					_valueDirty = true;
				}
			}
		}

		public int RelativeExp
		{
			get
			{
				int num = AccessTierIndex - 1;
				if (num < 0)
				{
					return Mathf.FloorToInt(TotalExp);
				}
				float f = TotalExp - AbsoluteThresholds[num];
				return Mathf.Min(NextLevelThreshold, Mathf.FloorToInt(f));
			}
		}

		public int NextLevelThreshold
		{
			get
			{
				if (AccessTierIndex >= _thresholdsCount)
				{
					return -1;
				}
				return _levelupThresholds[AccessTierIndex];
			}
		}

		public int AccessTierIndex
		{
			get
			{
				return Mathf.Clamp(_accessTier, 0, _thresholdsCount);
			}
			private set
			{
				if (_accessTier != value)
				{
					int num = value - _accessTier;
					for (int i = 0; i < num; i++)
					{
						_accessTier++;
						OnLevelledUp?.Invoke();
					}
					Scp079LevelingUpEventArgs e = new Scp079LevelingUpEventArgs(base.Owner, value + 1);
					Scp079Events.OnLevelingUp(e);
					if (e.IsAllowed)
					{
						_accessTier = value;
						OnTierChanged?.Invoke();
						Scp079Events.OnLeveledUp(new Scp079LeveledUpEventArgs(base.Owner, value + 1));
					}
				}
			}
		}

		public int AccessTierLevel => AccessTierIndex + 1;

		private void Update()
		{
			if (NetworkServer.active && _valueDirty)
			{
				ServerSendRpc(toAll: true);
				_valueDirty = false;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			int num = 0;
			_thresholdsCount = _levelupThresholds.Length;
			AbsoluteThresholds = new int[_thresholdsCount];
			for (int i = 0; i < _thresholdsCount; i++)
			{
				num += _levelupThresholds[i];
				AbsoluteThresholds[i] = num;
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			ReferenceHub.OnPlayerAdded += base.ServerSendRpc;
			TotalExp = 0;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			ReferenceHub.OnPlayerAdded -= base.ServerSendRpc;
		}

		public void ServerGrantExperience(int amount, Scp079HudTranslation reason, RoleTypeId subject = RoleTypeId.None)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("SCP-079 experience cannot be granted by local player!");
			}
			if (amount > 0)
			{
				_expGainQueue.Enqueue(new ExpQueuedNotification(amount, reason, subject));
				TotalExp += amount;
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteUShort((ushort)TotalExp);
			ExpQueuedNotification result;
			while (_expGainQueue.TryDequeue(out result))
			{
				result.Write(writer);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			ushort totalExp = reader.ReadUShort();
			if (!Scp079Role.LocalInstanceActive && !base.CastRole.IsSpectated && !NetworkServer.active)
			{
				TotalExp = totalExp;
				return;
			}
			while (reader.Remaining > 0)
			{
				ExpQueuedNotification expQueuedNotification = new ExpQueuedNotification(reader);
				if (expQueuedNotification.Subject.TryGetRoleTemplate<PlayerRoleBase>(out var result))
				{
					Scp079NotificationManager.AddNotification(expQueuedNotification.Reason, expQueuedNotification.ExpAmount, result.RoleName);
				}
			}
			if (!NetworkServer.active)
			{
				TotalExp = totalExp;
			}
		}
	}
}
