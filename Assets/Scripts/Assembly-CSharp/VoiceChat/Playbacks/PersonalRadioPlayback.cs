using System.Collections.Generic;
using System.Linq;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Radio;
using Mirror;
using PlayerRoles.Voice;
using RelativePositioning;
using UnityEngine;
using VoiceChat.Networking;

namespace VoiceChat.Playbacks
{
	public class PersonalRadioPlayback : VoiceChatPlaybackBase, IGlobalPlayback
	{
		public struct TransmitterPositionMessage : NetworkMessage
		{
			public RecyclablePlayerId Transmitter;

			public byte WaypointId;
		}

		[SerializeField]
		private AudioSource _noiseSource;

		private int _currentId;

		private bool _hasProximity;

		private bool _isLocalPlayer;

		private bool _recheckCachedRadio;

		private ReferenceHub _owner;

		private RadioItem _cachedRadio;

		private SingleBufferPlayback[] _proxPlaybacks;

		private readonly PlaybackBuffer _personalBuffer = new PlaybackBuffer();

		private const int RadioDelay = 4000;

		private const float ProxVolumeRatio = 0.35f;

		private static PersonalRadioPlayback _localPlayer;

		private static bool _hasLocalPlayer;

		private static int _freeIdsCount;

		private static int _lastTopNumber;

		private static float _noiseLevel;

		private static RadioItem _templateRadio;

		private static bool _templateRadioLoaded;

		private static readonly HashSet<int> FreeIds = new HashSet<int>();

		private int RangeId
		{
			get
			{
				if (!RadioMessages.SyncedRangeLevels.TryGetValue(_owner.netId, out var value))
				{
					return 1;
				}
				return Mathf.Abs((int)value.Range);
			}
		}

		private RadioItem RadioTemplate
		{
			get
			{
				if (_templateRadioLoaded)
				{
					return _templateRadio;
				}
				if (!InventoryItemLoader.TryGetItem<RadioItem>(ItemType.Radio, out var result))
				{
					return null;
				}
				_templateRadioLoaded = true;
				_templateRadio = result;
				return result;
			}
		}

		private static PersonalRadioPlayback LocalPlayer
		{
			get
			{
				return _localPlayer;
			}
			set
			{
				if (_hasLocalPlayer)
				{
					_localPlayer._isLocalPlayer = false;
				}
				if (value == null)
				{
					_localPlayer = null;
					_hasLocalPlayer = false;
				}
				else
				{
					_localPlayer = value;
					_hasLocalPlayer = true;
					value._isLocalPlayer = true;
				}
			}
		}

		public Vector3 LastKnownLocation { get; private set; }

		public int TemporaryId
		{
			get
			{
				UpdateTemporaryId();
				return _currentId;
			}
		}

		public bool RadioUsable
		{
			get
			{
				if (TryGetUserRadio(out var radio))
				{
					return radio.IsUsable;
				}
				return false;
			}
		}

		public override int MaxSamples => _personalBuffer.Length;

		public bool GlobalChatActive
		{
			get
			{
				if (IsTransmitting(_owner))
				{
					return !base.Source.mute;
				}
				return false;
			}
		}

		public Color GlobalChatColor => _owner.serverRoles.GetVoiceColor();

		public string GlobalChatName => _owner.nicknameSync.DisplayName;

		public float GlobalChatLoudness => base.Loudness;

		public GlobalChatIconType GlobalChatIcon => GlobalChatIconType.Radio;

		private void OnItemsModified(ReferenceHub hub)
		{
			if (!(hub != _owner))
			{
				_recheckCachedRadio = true;
			}
		}

		private void UpdateTemporaryId()
		{
			if (_personalBuffer.Length == 0)
			{
				if (_currentId != 0)
				{
					FreeIds.Add(_currentId);
					_freeIdsCount++;
					_currentId = 0;
				}
			}
			else if (_currentId == 0)
			{
				if (_freeIdsCount > 0)
				{
					_currentId = FreeIds.Min();
					_freeIdsCount--;
				}
				else
				{
					_currentId = ++_lastTopNumber;
				}
			}
		}

		private void UpdateLoudness()
		{
			if (!_hasLocalPlayer || _isLocalPlayer || !LocalPlayer.RadioUsable)
			{
				base.Source.mute = true;
				if (_hasProximity)
				{
					_proxPlaybacks.ForEach((SingleBufferPlayback x) =>
					{
						x.Source.volume = 1f;
					});
				}
				return;
			}
			int num = Mathf.Max(_localPlayer.RangeId, RangeId);
			RadioRangeMode radioRangeMode = RadioTemplate.Ranges[num];
			if (!radioRangeMode.CheckRange(MainCameraController.LastPosition, LastKnownLocation, out var sqrMag))
			{
				base.Source.mute = true;
				return;
			}
			base.Source.mute = false;
			float time = Mathf.Sqrt(sqrMag) / (float)radioRangeMode.MaximumRange;
			base.Source.volume = RadioTemplate.VoiceVolumeCurve.Evaluate(time);
			if (_personalBuffer.Length > 0)
			{
				_noiseLevel = Mathf.Max(_noiseLevel, RadioTemplate.NoiseLevelCurve.Evaluate(time));
			}
			if (_hasProximity)
			{
				SingleBufferPlayback[] proxPlaybacks = _proxPlaybacks;
				for (int num2 = 0; num2 < proxPlaybacks.Length; num2++)
				{
					proxPlaybacks[num2].Source.volume = ((_personalBuffer.Length > 0) ? 0.35f : 1f);
				}
			}
		}

		private void UpdateNoise()
		{
			if (_isLocalPlayer)
			{
				_noiseSource.volume = _noiseLevel;
				_noiseLevel = 0f;
			}
		}

		private bool TryGetUserRadio(out RadioItem radio)
		{
			if (_cachedRadio != null)
			{
				radio = _cachedRadio;
				return true;
			}
			radio = null;
			if (!_recheckCachedRadio)
			{
				return false;
			}
			foreach (KeyValuePair<ushort, ItemBase> item in _owner.inventory.UserInventory.Items)
			{
				if (item.Value.ItemTypeId == ItemType.Radio)
				{
					radio = (RadioItem)item.Value;
					break;
				}
			}
			if ((object)radio == null)
			{
				return false;
			}
			_cachedRadio = radio;
			return true;
		}

		protected override void OnDisable()
		{
			base.OnDisable();
			Inventory.OnItemsModified -= OnItemsModified;
			GlobalChatIndicatorManager.Unsubscribe(this);
			if (_isLocalPlayer)
			{
				LocalPlayer = null;
				_noiseSource.volume = 0f;
			}
		}

		protected override void Update()
		{
			base.Update();
			UpdateTemporaryId();
			UpdateLoudness();
			UpdateNoise();
			if (NetworkServer.active && IsTransmitting(_owner))
			{
				NetworkServer.SendToReady(new TransmitterPositionMessage
				{
					Transmitter = new RecyclablePlayerId(_owner),
					WaypointId = new RelativePosition(base.transform.position).WaypointId
				});
			}
		}

		protected override float ReadSample()
		{
			return _personalBuffer.Read();
		}

		public void Setup(ReferenceHub owner, SingleBufferPlayback[] proximityPlaybacks)
		{
			_owner = owner;
			_proxPlaybacks = proximityPlaybacks;
			_personalBuffer.Clear();
			Inventory.OnItemsModified += OnItemsModified;
			if (_owner.isLocalPlayer)
			{
				LocalPlayer = this;
				_noiseSource.volume = 0f;
				_noiseSource.Play();
			}
			else
			{
				_isLocalPlayer = false;
				GlobalChatIndicatorManager.Subscribe(this, owner);
				_noiseSource.Stop();
			}
			_hasProximity = _proxPlaybacks != null && _proxPlaybacks.Length != 0;
			_recheckCachedRadio = true;
		}

		public void DistributeSamples(float[] samples, int length)
		{
			RegisterInput();
			_personalBuffer.Write(samples, length);
			if (_hasProximity)
			{
				_personalBuffer.SyncWith(_proxPlaybacks[0].MaxSamples, 4000);
			}
			int num = TemporaryId - 1;
			if (num < 0 || num >= 8)
			{
				return;
			}
			foreach (SpatializedRadioPlaybackBase allInstance in SpatializedRadioPlaybackBase.AllInstances)
			{
				if (allInstance.IgnoredNetId == _owner.netId || allInstance.Culled)
				{
					continue;
				}
				RadioRangeMode radioRangeMode = RadioTemplate.Ranges[Mathf.Max(allInstance.RangeId, RangeId)];
				if (radioRangeMode.CheckRange(allInstance.LastPosition, LastKnownLocation, out var _))
				{
					allInstance.RegisterInput();
					PlaybackBuffer playbackBuffer = allInstance.Buffers[num];
					playbackBuffer.Write(samples, length);
					if (_hasProximity)
					{
						playbackBuffer.SyncWith(_proxPlaybacks[0].MaxSamples, 4000);
					}
				}
			}
		}

		public static bool IsTransmitting(ReferenceHub hub)
		{
			if (!(hub.roleManager.CurrentRole is IVoiceRole { VoiceModule: var voiceModule }))
			{
				return false;
			}
			if (!(voiceModule is IRadioVoiceModule))
			{
				return false;
			}
			if (hub.isLocalPlayer)
			{
				return VoiceChatMicCapture.GetCurrentChannel() == VoiceChatChannel.Radio;
			}
			if (NetworkServer.active ? voiceModule.ServerIsSending : voiceModule.IsSpeaking)
			{
				return voiceModule.CurrentChannel == VoiceChatChannel.Radio;
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler((TransmitterPositionMessage msg) =>
				{
					if (ReferenceHub.TryGetHub(msg.Transmitter.Value, out var hub) && hub.roleManager.CurrentRole is IVoiceRole { VoiceModule: IRadioVoiceModule voiceModule })
					{
						voiceModule.RadioPlayback.LastKnownLocation = WaypointBase.GetWorldPosition(msg.WaypointId, Vector3.zero);
					}
				});
			};
		}
	}
}
