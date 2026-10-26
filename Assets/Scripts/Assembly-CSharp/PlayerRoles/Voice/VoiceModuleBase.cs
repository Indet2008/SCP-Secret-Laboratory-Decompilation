using System.Diagnostics;
using GameObjectPools;
using Mirror;
using UnityEngine;
using VoiceChat;
using VoiceChat.Codec;
using VoiceChat.Networking;

namespace PlayerRoles.Voice
{
	public abstract class VoiceModuleBase : MonoBehaviour, IPoolResettable, IPoolSpawnable
	{
		public delegate void SamplesReceived(float[] samples, int len);

		private VoiceChatChannel _lastChannel;

		private OpusDecoder _defaultDecoder;

		private ReferenceHub _owner;

		private int _sentPackets;

		private int _prevSent;

		private const float SilenceTolerance = 0.1f;

		private const float RateLimiterTimeframe = 0.5f;

		private const int RateLimiterTolerance = 128;

		private readonly Stopwatch _rateStopwatch = Stopwatch.StartNew();

		private readonly Stopwatch _silenceStopwatch = Stopwatch.StartNew();

		private static float[] _receiveBuffer;

		private static bool _receiveBufferSet;

		protected ReferenceHub Owner => _owner;

		protected virtual OpusDecoder Decoder => _defaultDecoder;

		public PlayerRoleBase Role { get; private set; }

		public bool ServerIsSending { get; private set; }

		public GroupMuteFlags ReceiveFlags { get; set; }

		public VoiceChatChannel CurrentChannel
		{
			get
			{
				return _lastChannel;
			}
			internal set
			{
				if (_lastChannel != value)
				{
					_lastChannel = value;
					OnChannelChanged();
				}
			}
		}

		public abstract bool IsSpeaking { get; }

		public event SamplesReceived OnSamplesReceived;

		protected virtual void Awake()
		{
			Role = GetComponent<PlayerRoleBase>();
		}

		protected virtual void Update()
		{
			if (_sentPackets > _prevSent)
			{
				ServerIsSending = true;
				_silenceStopwatch.Restart();
			}
			else if (ServerIsSending && _silenceStopwatch.Elapsed.TotalSeconds > 0.10000000149011612)
			{
				ServerIsSending = false;
			}
			if (_rateStopwatch.Elapsed.TotalSeconds >= 0.5)
			{
				_sentPackets = 0;
				_rateStopwatch.Restart();
			}
			_prevSent = _sentPackets;
		}

		protected virtual void OnChannelChanged()
		{
		}

		protected abstract void ProcessSamples(float[] data, int len);

		public abstract VoiceChatChannel GetUserInput();

		public virtual VoiceChatChannel ValidateSend(VoiceChatChannel channel)
		{
			return channel;
		}

		public virtual VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			return channel;
		}

		public virtual void ResetObject()
		{
			_lastChannel = VoiceChatChannel.None;
			_defaultDecoder?.Dispose();
			ReceiveFlags = GroupMuteFlags.None;
		}

		public virtual void SpawnObject()
		{
			if (Role.TryGetOwner(out _owner))
			{
				_defaultDecoder = new OpusDecoder();
				if (Owner.isLocalPlayer)
				{
					VoiceChatMicCapture.StartRecording();
				}
				if (NetworkServer.active)
				{
					ReceiveFlags = VoiceChatReceivePrefs.GetFlagsForUser(Owner);
				}
			}
		}

		public bool CheckRateLimit()
		{
			return _sentPackets++ < 128;
		}

		public void ProcessMessage(VoiceMessage msg)
		{
			CurrentChannel = msg.Channel;
			if (!_receiveBufferSet)
			{
				_receiveBufferSet = true;
				_receiveBuffer = new float[24000];
			}
			int len = Decoder.Decode(msg.Data, msg.DataLength, _receiveBuffer);
			if (Owner.isLocalPlayer || VoiceChatMutes.GetFlags(Owner) == VcMuteFlags.None)
			{
				ProcessSamples(_receiveBuffer, len);
				OnSamplesReceived?.Invoke(_receiveBuffer, len);
			}
		}
	}
}
