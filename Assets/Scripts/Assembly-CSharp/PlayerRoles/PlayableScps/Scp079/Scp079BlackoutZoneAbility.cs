using System;
using System.Text;
using AudioPooling;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.PlayableScps.Scp079.Map;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079BlackoutZoneAbility : Scp079KeyAbilityBase, IScp079LevelUpNotifier
	{
		private enum ValidationError
		{
			None = 0,
			NotEnoughAux = 1,
			Cooldown = 59,
			Unavailable = 61
		}

		public static Action<ReferenceHub, FacilityZone> OnClientZoneBlackout;

		[SerializeField]
		private int _cost;

		[SerializeField]
		private float _duration;

		[SerializeField]
		private float _cooldown;

		[SerializeField]
		private int _minTierIndex;

		[SerializeField]
		private FacilityZone[] _availableZones;

		private readonly AbilityCooldown _cooldownTimer = new AbilityCooldown();

		private string _nameFormat;

		private string _textUnlock;

		private string _failMessage;

		private bool _hasFailMessage;

		private FacilityZone _syncZone;

		private Scp079HudTranslation _failReason;

		public override ActionName ActivationKey => ActionName.Shoot;

		public override bool IsReady => ErrorCode == Scp079HudTranslation.Zoom;

		public override string AbilityName => string.Format(_nameFormat, _cost);

		public override bool IsVisible
		{
			get
			{
				if (Scp079Role.LocalInstanceActive && Unlocked && !Cursor.visible && Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen)
				{
					return _syncZone != FacilityZone.None;
				}
				return false;
			}
		}

		public bool Unlocked => base.TierManager.AccessTierIndex >= _minTierIndex;

		private Scp079HudTranslation ErrorCode
		{
			get
			{
				if (!Unlocked)
				{
					return Scp079HudTranslation.ZoneBlackoutUnavailable;
				}
				if (!_availableZones.Contains(_syncZone))
				{
					return Scp079HudTranslation.ZoneBlackoutUnavailable;
				}
				if (!_cooldownTimer.IsReady)
				{
					return Scp079HudTranslation.ZoneBlackoutCooldown;
				}
				if (base.AuxManager.CurrentAuxFloored < _cost)
				{
					return Scp079HudTranslation.NotEnoughAux;
				}
				return Scp079HudTranslation.Zoom;
			}
		}

		public override string FailMessage
		{
			get
			{
				if (!_hasFailMessage)
				{
					return null;
				}
				switch (_failReason)
				{
				case Scp079HudTranslation.Zoom:
					return null;
				case Scp079HudTranslation.NotEnoughAux:
					if (base.AuxManager.CurrentAuxFloored >= _cost)
					{
						return null;
					}
					return GetNoAuxMessage(_cost);
				case Scp079HudTranslation.ZoneBlackoutCooldown:
					if (_cooldownTimer.IsReady)
					{
						return null;
					}
					return _failMessage + "\n" + base.AuxManager.GenerateCustomETA(Mathf.CeilToInt(_cooldownTimer.Remaining));
				default:
					return _failMessage;
				}
			}
		}

		protected override void Start()
		{
			base.Start();
			_nameFormat = Translations.Get(Scp079HudTranslation.ActivateZoneBlackout);
			_textUnlock = Translations.Get(Scp079HudTranslation.ZoneBlackoutAvailable);
		}

		protected override void Update()
		{
			base.Update();
			if (base.Owner.isLocalPlayer)
			{
				_syncZone = ZoneBlackoutIcon.HighlightedZone;
			}
		}

		public override void OnFailMessageAssigned()
		{
			base.OnFailMessageAssigned();
			_hasFailMessage = true;
			_failReason = ErrorCode;
			_failMessage = Translations.Get(_failReason);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_cooldownTimer.Clear();
		}

		public bool WriteLevelUpNotification(StringBuilder sb, int newLevel)
		{
			if (newLevel != _minTierIndex)
			{
				return false;
			}
			sb.Append(_textUnlock);
			return true;
		}

		protected override void Trigger()
		{
			ClientSendCmd();
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteByte((byte)_syncZone);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_syncZone = (FacilityZone)reader.ReadByte();
			if (ErrorCode != Scp079HudTranslation.Zoom)
			{
				return;
			}
			Scp079BlackingOutZoneEventArgs e = new Scp079BlackingOutZoneEventArgs(base.Owner, _syncZone);
			Scp079Events.OnBlackingOutZone(e);
			if (!e.IsAllowed)
			{
				return;
			}
			foreach (RoomLightController instance in RoomLightController.Instances)
			{
				if (instance.Room.Zone == _syncZone)
				{
					instance.ServerFlickerLights(_duration);
				}
			}
			_cooldownTimer.Trigger(_cooldown);
			base.AuxManager.CurrentAux -= _cost;
			ServerSendRpc(toAll: true);
			Scp079Events.OnBlackedOutZone(new Scp079BlackedOutZoneEventArgs(base.Owner, _syncZone));
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_syncZone);
			_cooldownTimer.WriteCooldown(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			_syncZone = (FacilityZone)reader.ReadByte();
			_cooldownTimer.ReadCooldown(reader);
			OnClientZoneBlackout?.Invoke(base.Owner, _syncZone);
			if (!base.CastRole.SubroutineModule.TryGetSubroutine<Scp079BlackoutRoomAbility>(out var subroutine))
			{
				return;
			}
			if (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated())
			{
				AudioSourcePoolManager.Play2D(subroutine.ConfirmationSound);
				return;
			}
			foreach (RoomLightController instance in RoomLightController.Instances)
			{
				if (instance.Room.Zone == _syncZone)
				{
					subroutine.PlaySoundForController(instance);
				}
			}
		}
	}
}
