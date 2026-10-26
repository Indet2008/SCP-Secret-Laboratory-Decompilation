using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;
using VoiceChat;
using VoiceChat.Networking;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryTransmitter : StandardSubroutine<Scp939Role>
	{
		private PlaybackBuffer _copierPlayback;

		private PlaybackBuffer _senderPlayback;

		private int _playbackSize;

		private int _allowedSamples;

		private int _samplesPerSecond;

		private const int HeadSamples = 1920;

		public bool IsTransmitting
		{
			get
			{
				PlaybackBuffer copierPlayback = _copierPlayback;
				if (copierPlayback == null || copierPlayback.Length <= 0)
				{
					PlaybackBuffer senderPlayback = _senderPlayback;
					if (senderPlayback == null)
					{
						return false;
					}
					return senderPlayback.Length > 0;
				}
				return true;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_samplesPerSecond = 48000;
		}

		public void SendVoice(PlaybackBuffer pb, int startSample, int maxLength)
		{
			pb.Reorganize();
			int num = pb.Buffer.Length;
			if (_playbackSize < num)
			{
				_copierPlayback = new PlaybackBuffer(num);
				_senderPlayback = new PlaybackBuffer(num);
				_playbackSize = num;
			}
			else
			{
				_copierPlayback.Clear();
				_senderPlayback.Clear();
			}
			_allowedSamples = 1920;
			_copierPlayback.Write(pb.Buffer, Mathf.Min(maxLength, pb.Length), startSample);
		}

		public void StopTransmission()
		{
			if (IsTransmitting)
			{
				_copierPlayback?.Clear();
				_senderPlayback?.Clear();
				ClientSendCmd();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			ServerSendRpc(toAll: true);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			(base.CastRole.VoiceModule as Scp939VoiceModule).ClearMimicryPlayback();
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_copierPlayback?.Clear();
			_senderPlayback?.Clear();
		}

		private void Update()
		{
			if (base.Owner.isLocalPlayer && _playbackSize != 0)
			{
				_allowedSamples += Mathf.CeilToInt(Time.deltaTime * (float)_samplesPerSecond);
				int num = Mathf.Min(_allowedSamples, _copierPlayback.Length);
				if (num > 0)
				{
					_copierPlayback.ReadTo(_senderPlayback.Buffer, num, _senderPlayback.WriteHead);
					_senderPlayback.WriteHead += num;
				}
				_allowedSamples = 0;
				VoiceTransceiver.ClientSendData(_senderPlayback, VoiceChatChannel.Mimicry, 1);
			}
		}
	}
}
