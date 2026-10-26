using System;
using System.Text;
using GameObjectPools;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079DoorLockChanger : Scp079DoorAbility, IPoolResettable, IScp079AuxRegenModifier, IScp079LevelUpNotifier
	{
		[SerializeField]
		private AudioClip _lockSound;

		[SerializeField]
		private AudioClip _unlockSound;

		[SerializeField]
		private float _costMaxAuxPercent;

		[SerializeField]
		private int _costRounding;

		[SerializeField]
		private float _cooldownBaseline;

		[SerializeField]
		private float _cooldownPerTimeLocked;

		[SerializeField]
		private float _lockCostPerSec;

		[SerializeField]
		private float _lockCostPow;

		[SerializeField]
		private AudioClip _whirSound;

		[SerializeField]
		private int _minTierIndex;

		private static string _lockText;

		private static string _unlockText;

		private static string _cooldownText;

		private static string _alreadyLockedText;

		private static string _abilityUnlockText;

		private readonly AbilityCooldown _cooldown = new AbilityCooldown();

		private DoorVariant _failedDoor;

		private double _lockTime;

		private const DoorLockReason LockReason = DoorLockReason.Regular079;

		public override ActionName ActivationKey => ActionName.Scp079LockDoor;

		public float AuxRegenMultiplier
		{
			get
			{
				if (!(LockedDoor != null))
				{
					return 1f;
				}
				return 0f;
			}
		}

		public string AuxReductionMessage { get; private set; }

		public DoorVariant LockedDoor { get; private set; }

		public override string AbilityName => string.Format(IsHighlightLockedBy079 ? _unlockText : _lockText, GetCostForDoor(TargetAction, LastDoor));

		public override bool IsReady
		{
			get
			{
				if (base.TierManager.AccessTierIndex < _minTierIndex)
				{
					return false;
				}
				if (!base.IsReady)
				{
					return false;
				}
				if (TargetAction == DoorAction.Unlocked)
				{
					return true;
				}
				if (LockedDoor == null && !Scp079LockdownRoomAbility.IsLockedDown(LastDoor))
				{
					return _cooldown.IsReady;
				}
				return false;
			}
		}

		public override bool IsVisible
		{
			get
			{
				if (base.IsVisible)
				{
					return base.TierManager.AccessTierIndex >= _minTierIndex;
				}
				return false;
			}
		}

		public override string FailMessage
		{
			get
			{
				if (_failedDoor == null)
				{
					return null;
				}
				if (LockedDoor != null && _failedDoor != LockedDoor)
				{
					return _alreadyLockedText;
				}
				if (Scp079LockdownRoomAbility.IsLockedDown(_failedDoor))
				{
					return _alreadyLockedText;
				}
				if (_cooldown.Remaining == 0f)
				{
					return base.FailMessage;
				}
				int secondsRemaining = Mathf.CeilToInt(_cooldown.Remaining);
				return _cooldownText + "\n" + base.AuxManager.GenerateCustomETA(secondsRemaining);
			}
		}

		public int LockClosedDoorCost
		{
			get
			{
				int num = (int)(base.AuxManager.MaxAux * _costMaxAuxPercent);
				int num2 = num % _costRounding;
				return num + num2;
			}
		}

		[field: SerializeField]
		public int LockOpenDoorCost { get; private set; }

		protected override DoorAction TargetAction
		{
			get
			{
				if (!IsHighlightLockedBy079)
				{
					return DoorAction.Locked;
				}
				return DoorAction.Unlocked;
			}
		}

		private bool IsHighlightLockedBy079 => ((DoorLockReason)LastDoor.ActiveLocks).HasFlagFast(DoorLockReason.Regular079);

		public static event Action<Scp079Role, DoorVariant> OnServerDoorLocked;

		protected override int GetCostForDoor(DoorAction action, DoorVariant door)
		{
			if (action != DoorAction.Locked)
			{
				return 0;
			}
			if (!door.TargetState)
			{
				return LockClosedDoorCost;
			}
			return LockOpenDoorCost;
		}

		protected virtual void OnDestroy()
		{
			ServerUnlock();
		}

		protected override void Start()
		{
			base.Start();
			_lockText = Translations.Get(Scp079HudTranslation.LockDoor);
			_unlockText = Translations.Get(Scp079HudTranslation.UnlockDoor);
			_cooldownText = Translations.Get(Scp079HudTranslation.DoorLockCooldown);
			_alreadyLockedText = Translations.Get(Scp079HudTranslation.DoorLockAlreadyActive);
			AuxReductionMessage = Translations.Get(Scp079HudTranslation.DoorLockAuxPause);
			_abilityUnlockText = Translations.Get(Scp079HudTranslation.DoorLockAbilityAvailable);
			base.LostSignalHandler.OnStatusChanged += () =>
			{
				if (NetworkServer.active && base.LostSignalHandler.Lost)
				{
					ServerUnlock();
				}
			};
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && !(LockedDoor == null))
			{
				float num = base.AuxManager.CurrentAux;
				if (LockedDoor.TargetState)
				{
					_lockTime = NetworkTime.time;
				}
				else
				{
					float num2 = (float)(NetworkTime.time - _lockTime);
					num -= Mathf.Pow(num2 * _lockCostPerSec, _lockCostPow) * Time.deltaTime;
					base.AuxManager.CurrentAux = num;
				}
				if (!(num > 0f) || !Scp079DoorAbility.ValidateAction(DoorAction.Locked, LockedDoor, base.CurrentCamSync.CurrentCamera))
				{
					ServerUnlock();
				}
			}
		}

		public void ServerUnlock()
		{
			if (NetworkServer.active && !(LockedDoor == null))
			{
				Scp079UnlockingDoorEventArgs e = new Scp079UnlockingDoorEventArgs(base.Owner, LockedDoor);
				Scp079Events.OnUnlockingDoor(e);
				if (e.IsAllowed)
				{
					double num = (NetworkTime.time - _lockTime) * (double)_cooldownPerTimeLocked;
					_cooldown.Trigger(num + (double)_cooldownBaseline);
					LockedDoor.ServerChangeLock(DoorLockReason.Regular079, newState: false);
					Scp079Events.OnUnlockedDoor(new Scp079UnlockedDoorEventArgs(base.Owner, LockedDoor));
					LockedDoor = null;
					ServerSendRpc(toAll: true);
				}
			}
		}

		public override void OnFailMessageAssigned()
		{
			base.OnFailMessageAssigned();
			_failedDoor = LastDoor;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteUInt(LastDoor.netId);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (!NetworkServer.spawned.TryGetValue(reader.ReadUInt(), out var value) || !value.TryGetComponent<DoorVariant>(out LastDoor) || !IsReady)
			{
				return;
			}
			if (TargetAction == DoorAction.Locked)
			{
				if (base.LostSignalHandler.Lost)
				{
					return;
				}
				Scp079LockingDoorEventArgs e = new Scp079LockingDoorEventArgs(base.Owner, LastDoor);
				Scp079Events.OnLockingDoor(e);
				if (!e.IsAllowed)
				{
					return;
				}
				_lockTime = NetworkTime.time;
				LockedDoor = LastDoor;
				LockedDoor.ServerChangeLock(DoorLockReason.Regular079, newState: true);
				base.RewardManager.MarkRooms(LastDoor.Rooms);
				OnServerDoorLocked?.Invoke(base.CastRole, LastDoor);
				base.AuxManager.CurrentAux -= GetCostForDoor(DoorAction.Locked, LastDoor);
				Scp079Events.OnLockedDoor(new Scp079LockedDoorEventArgs(base.Owner, LastDoor));
			}
			else if (LastDoor == LockedDoor)
			{
				ServerUnlock();
			}
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			_cooldown.WriteCooldown(writer);
			writer.WriteNetworkBehaviour(LockedDoor);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_failedDoor = null;
			_cooldown.ReadCooldown(reader);
			DoorVariant lockedDoor = LockedDoor;
			DoorVariant doorVariant = reader.ReadNetworkBehaviour<DoorVariant>();
			if (!(doorVariant == lockedDoor) || NetworkServer.active)
			{
				LockedDoor = doorVariant;
				if (doorVariant == null)
				{
					PlayConfirmationSound(_unlockSound);
					return;
				}
				new Scp079DoorWhir(base.CastRole, _whirSound);
				PlayConfirmationSound(_lockSound);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			ServerUnlock();
			_cooldown.Clear();
		}

		public bool WriteLevelUpNotification(StringBuilder sb, int newLevel)
		{
			if (newLevel != _minTierIndex)
			{
				return false;
			}
			sb.AppendFormat(_abilityUnlockText, $"[{new ReadableKeyCode(ActivationKey)}]");
			return true;
		}
	}
}
