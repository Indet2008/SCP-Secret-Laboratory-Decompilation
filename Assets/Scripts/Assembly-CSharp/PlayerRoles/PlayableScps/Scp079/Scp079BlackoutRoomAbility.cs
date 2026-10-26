using System.Collections.Generic;
using System.Text;
using AudioPooling;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079BlackoutRoomAbility : Scp079KeyAbilityBase, IScp079LevelUpNotifier
	{
		private enum ValidationError
		{
			None = 0,
			NotEnoughAux = 1,
			NoController = 26,
			MaxCapacityReached = 27,
			RoomOnCooldown = 28,
			AlreadyBlackedOut = 60
		}

		[SerializeField]
		private int[] _capacityPerTier;

		[SerializeField]
		private float _blackoutDuration;

		[SerializeField]
		private float _cooldown;

		[SerializeField]
		private int _cost;

		[SerializeField]
		private int _surfaceCost;

		private string _textUnlock;

		private string _textCapacityIncreased;

		private string _nameFormat;

		private string _failMessage;

		private bool _hasFailMessage;

		private bool _hasController;

		private RoomLightController _successfulController;

		private RoomLightController _roomController;

		private readonly Dictionary<uint, double> _blackoutCooldowns = new Dictionary<uint, double>();

		private readonly HashSet<uint> _obsoleteCooldowns = new HashSet<uint>();

		public override ActionName ActivationKey => ActionName.Scp079Blackout;

		public override bool IsReady => ErrorCode == Scp079HudTranslation.Zoom;

		public override bool IsVisible
		{
			get
			{
				if (CurrentCapacity > 0)
				{
					return !Scp079CursorManager.LockCameras;
				}
				return false;
			}
		}

		public override string AbilityName => string.Format(_nameFormat, AbilityCost);

		public override bool DummyEmulationSupport => true;

		public override string FailMessage
		{
			get
			{
				if (!_hasFailMessage)
				{
					return null;
				}
				return ErrorCode switch
				{
					Scp079HudTranslation.Zoom => null, 
					Scp079HudTranslation.NotEnoughAux => GetNoAuxMessage(AbilityCost), 
					Scp079HudTranslation.BlackoutRoomCooldown => _failMessage + "\n" + base.AuxManager.GenerateCustomETA(Mathf.CeilToInt(RemainingCooldown)), 
					Scp079HudTranslation.BlackoutRoomLimit => string.Format(_failMessage, RoomsOnCooldown, CurrentCapacity), 
					_ => _failMessage, 
				};
			}
		}

		[field: SerializeField]
		public AudioClip ConfirmationSound { get; private set; }

		private int CurrentCapacity => GetCapacityOfTier(base.TierManager.AccessTierIndex);

		private int RoomsOnCooldown
		{
			get
			{
				int num = 0;
				bool flag = false;
				foreach (KeyValuePair<uint, double> blackoutCooldown in _blackoutCooldowns)
				{
					if (blackoutCooldown.Value < NetworkTime.time)
					{
						_obsoleteCooldowns.Add(blackoutCooldown.Key);
						flag = true;
					}
					else
					{
						num++;
					}
				}
				if (!flag)
				{
					return num;
				}
				foreach (uint obsoleteCooldown in _obsoleteCooldowns)
				{
					_blackoutCooldowns.Remove(obsoleteCooldown);
				}
				_obsoleteCooldowns.Clear();
				return num;
			}
		}

		private float RemainingCooldown
		{
			get
			{
				if (!_hasController || !_blackoutCooldowns.TryGetValue(_roomController.netId, out var value))
				{
					return 0f;
				}
				double num = value - NetworkTime.time;
				return Mathf.Max(0f, (float)num);
			}
		}

		private Scp079HudTranslation ErrorCode
		{
			get
			{
				if (!_hasController)
				{
					return Scp079HudTranslation.BlackoutRoomUnavailable;
				}
				if (!_roomController.LightsEnabled)
				{
					return Scp079HudTranslation.BlackoutAlreadyActive;
				}
				if (RemainingCooldown > 0f)
				{
					return Scp079HudTranslation.BlackoutRoomCooldown;
				}
				if (RoomsOnCooldown >= CurrentCapacity)
				{
					return Scp079HudTranslation.BlackoutRoomLimit;
				}
				if ((float)base.AuxManager.CurrentAuxFloored < AbilityCost)
				{
					return Scp079HudTranslation.NotEnoughAux;
				}
				return Scp079HudTranslation.Zoom;
			}
		}

		private bool IsOnSurface => base.CurrentCamSync.CurrentCamera.Room.Zone == FacilityZone.Surface;

		private float AbilityCost => IsOnSurface ? _surfaceCost : _cost;

		private void RefreshCurrentController()
		{
			_hasController = false;
			_hasFailMessage = false;
			_failMessage = null;
			RoomIdentifier room = base.CurrentCamSync.CurrentCamera.Room;
			foreach (RoomLightController instance in RoomLightController.Instances)
			{
				if (!(instance.Room != room))
				{
					float y = base.CurrentCamSync.CurrentCamera.Position.y;
					float y2 = instance.transform.position.y;
					if (!(Mathf.Abs(y - y2) > 50f))
					{
						_roomController = instance;
						_hasController = true;
						break;
					}
				}
			}
		}

		private int GetCapacityOfTier(int index)
		{
			index = Mathf.Clamp(index, 0, _capacityPerTier.Length - 1);
			return _capacityPerTier[index];
		}

		protected override void Start()
		{
			base.Start();
			_nameFormat = Translations.Get(Scp079HudTranslation.ActivateRoomBlackout);
			_textUnlock = Translations.Get(Scp079HudTranslation.BlackoutRoomAvailable);
			_textCapacityIncreased = Translations.Get(Scp079HudTranslation.BlackoutCapacityIncreased);
			base.CurrentCamSync.OnCameraChanged += RefreshCurrentController;
		}

		protected override void Trigger()
		{
			ClientSendCmd();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (IsReady && !base.LostSignalHandler.Lost)
			{
				Scp079BlackingOutRoomEventsArgs scp079BlackingOutRoomEventsArgs = new Scp079BlackingOutRoomEventsArgs(base.Owner, _roomController.Room);
				Scp079Events.OnBlackingOutRoom(scp079BlackingOutRoomEventsArgs);
				if (scp079BlackingOutRoomEventsArgs.IsAllowed)
				{
					base.AuxManager.CurrentAux -= AbilityCost;
					base.RewardManager.MarkRoom(_roomController.Room);
					_blackoutCooldowns[_roomController.netId] = NetworkTime.time + (double)_cooldown;
					_roomController.ServerFlickerLights(_blackoutDuration);
					_successfulController = _roomController;
					ServerSendRpc(toAll: true);
					Scp079Events.OnBlackedOutRoom(new Scp079BlackedOutRoomEventArgs(base.Owner, _roomController.Room));
				}
			}
			else
			{
				_successfulController = null;
				ServerSendRpc(toAll: false);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteNetworkBehaviour(_successfulController);
			writer.WriteByte((byte)RoomsOnCooldown);
			foreach (KeyValuePair<uint, double> blackoutCooldown in _blackoutCooldowns)
			{
				writer.WriteUInt(blackoutCooldown.Key);
				writer.WriteDouble(blackoutCooldown.Value);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_successfulController = reader.ReadNetworkBehaviour<RoomLightController>();
			if (_successfulController != null)
			{
				PlaySoundForController(_successfulController);
			}
			int num = reader.ReadByte();
			_blackoutCooldowns.Clear();
			for (int i = 0; i < num; i++)
			{
				uint key = reader.ReadUInt();
				double value = reader.ReadDouble();
				_blackoutCooldowns.Add(key, value);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_blackoutCooldowns.Clear();
			_obsoleteCooldowns.Clear();
		}

		public void PlaySoundForController(RoomLightController flc)
		{
			Vector3 position = flc.transform.position + Vector3.down * 15f;
			AudioSourcePoolManager.PlayAtPosition(ConfirmationSound, position, 37f, 1f, FalloffType.Linear).Source.minDistance = 15f;
		}

		public override void OnFailMessageAssigned()
		{
			base.OnFailMessageAssigned();
			_hasFailMessage = true;
			_failMessage = Translations.Get(ErrorCode);
		}

		public bool WriteLevelUpNotification(StringBuilder sb, int newLevel)
		{
			int capacityOfTier = GetCapacityOfTier(newLevel);
			int capacityOfTier2 = GetCapacityOfTier(newLevel - 1);
			if (capacityOfTier <= capacityOfTier2)
			{
				return false;
			}
			if (capacityOfTier2 > 0)
			{
				sb.AppendFormat(_textCapacityIncreased, capacityOfTier);
			}
			else
			{
				sb.AppendFormat(_textUnlock, $"[{new ReadableKeyCode(ActivationKey)}]");
			}
			return true;
		}
	}
}
