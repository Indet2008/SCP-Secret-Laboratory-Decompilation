using UnityEngine;
using VoiceChat;
using VoiceChat.Codec;
using VoiceChat.Playbacks;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939VoiceModule : StandardScpVoiceModule
	{
		[SerializeField]
		private SingleBufferPlayback[] _mimicrySources;

		private OpusDecoder _mimicryDecoder;

		private bool _mimicryDecoderSet;

		public const VoiceChatChannel MimicryChannel = VoiceChatChannel.Mimicry;

		protected override OpusDecoder Decoder
		{
			get
			{
				if (base.CurrentChannel != VoiceChatChannel.Mimicry)
				{
					return base.Decoder;
				}
				if (!_mimicryDecoderSet)
				{
					_mimicryDecoder = new OpusDecoder();
					_mimicryDecoderSet = true;
				}
				return _mimicryDecoder;
			}
		}

		protected override void ProcessSamples(float[] data, int len)
		{
			if (base.CurrentChannel == VoiceChatChannel.Mimicry)
			{
				SingleBufferPlayback[] mimicrySources = _mimicrySources;
				for (int i = 0; i < mimicrySources.Length; i++)
				{
					mimicrySources[i].WriteBuffer(data, len);
				}
			}
			else
			{
				base.ProcessSamples(data, len);
			}
		}

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			if (channel != VoiceChatChannel.Mimicry)
			{
				return base.ValidateReceive(speaker, channel);
			}
			return channel;
		}

		public override VoiceChatChannel ValidateSend(VoiceChatChannel channel)
		{
			if (channel != VoiceChatChannel.Mimicry)
			{
				return base.ValidateSend(channel);
			}
			return channel;
		}

		public void ClearMimicryPlayback()
		{
			SingleBufferPlayback[] mimicrySources = _mimicrySources;
			for (int i = 0; i < mimicrySources.Length; i++)
			{
				mimicrySources[i].ClearBuffer();
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_mimicryDecoderSet)
			{
				_mimicryDecoder?.Dispose();
				_mimicryDecoderSet = false;
			}
		}
	}
}
