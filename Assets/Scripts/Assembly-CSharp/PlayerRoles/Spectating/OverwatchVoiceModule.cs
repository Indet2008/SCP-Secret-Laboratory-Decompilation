using System;
using VoiceChat;

namespace PlayerRoles.Spectating
{
	public class OverwatchVoiceModule : SpectatorVoiceModule
	{
		public VoiceChatChannel[] DisabledChannels { get; set; } = Array.Empty<VoiceChatChannel>();

		public bool UseSpatialAudio { get; set; } = true;

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			if (channel != VoiceChatChannel.Scp1576 && channel != VoiceChatChannel.ScpChat && channel != VoiceChatChannel.PreGameLobby)
			{
				channel = base.ValidateReceive(speaker, channel);
			}
			if (!UseSpatialAudio && (channel == VoiceChatChannel.Proximity || channel == VoiceChatChannel.Mimicry || channel == VoiceChatChannel.Radio) && !DisabledChannels.Contains(channel))
			{
				return VoiceChatChannel.RoundSummary;
			}
			if (!DisabledChannels.Contains(channel))
			{
				return channel;
			}
			return VoiceChatChannel.None;
		}
	}
}
