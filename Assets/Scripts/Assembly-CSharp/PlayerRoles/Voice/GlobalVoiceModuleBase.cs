using PlayerRoles.Spectating;
using VoiceChat;

namespace PlayerRoles.Voice
{
	public abstract class GlobalVoiceModuleBase : StandardVoiceModule
	{
		public override bool IsSpeaking => base.GlobalChatActive;

		protected abstract VoiceChatChannel PrimaryChannel { get; }

		public override VoiceChatChannel ValidateSend(VoiceChatChannel channel)
		{
			if (channel != PrimaryChannel)
			{
				return VoiceChatChannel.None;
			}
			return channel;
		}

		protected override void ProcessSamples(float[] data, int len)
		{
			GlobalPlayback.WriteBuffer(data, len);
		}

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			channel = base.ValidateReceive(speaker, channel);
			if (channel == PrimaryChannel)
			{
				return channel;
			}
			switch (channel)
			{
			case VoiceChatChannel.Radio:
			case VoiceChatChannel.Intercom:
				if (speaker.roleManager.CurrentRole is SpectatorRole)
				{
					return VoiceChatChannel.None;
				}
				return channel;
			case VoiceChatChannel.Proximity:
			case VoiceChatChannel.RoundSummary:
			case VoiceChatChannel.Mimicry:
				return channel;
			default:
				return VoiceChatChannel.None;
			}
		}

		protected override VoiceChatChannel ProcessInputs(bool primary, bool alt)
		{
			if (!primary)
			{
				return VoiceChatChannel.None;
			}
			return PrimaryChannel;
		}
	}
}
