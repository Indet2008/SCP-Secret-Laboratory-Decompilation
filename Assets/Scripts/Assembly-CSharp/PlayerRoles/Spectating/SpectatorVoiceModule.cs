using InventorySystem.Items.Usables.Scp1576;
using PlayerRoles.Voice;
using VoiceChat;
using VoiceChat.Playbacks;

namespace PlayerRoles.Spectating
{
	public class SpectatorVoiceModule : GlobalVoiceModuleBase
	{
		protected override VoiceChatChannel PrimaryChannel => VoiceChatChannel.Spectator;

		public override GlobalChatIconType GlobalChatIcon => GlobalChatIconType.None;

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			if (channel == VoiceChatChannel.PreGameLobby && !RoundSummary.RoundInProgress() && base.Owner.roleManager.CurrentRole is SpectatorRole)
			{
				return VoiceChatChannel.Spectator;
			}
			if (channel != VoiceChatChannel.Scp1576)
			{
				channel = base.ValidateReceive(speaker, channel);
			}
			switch (channel)
			{
			case VoiceChatChannel.Proximity:
			case VoiceChatChannel.Radio:
			case VoiceChatChannel.Intercom:
			case VoiceChatChannel.Scp1576:
				if ((base.ReceiveFlags & GroupMuteFlags.Alive) != GroupMuteFlags.None)
				{
					return VoiceChatChannel.None;
				}
				break;
			case VoiceChatChannel.Spectator:
				if ((base.ReceiveFlags & GroupMuteFlags.Spectators) != GroupMuteFlags.None)
				{
					return VoiceChatChannel.None;
				}
				break;
			}
			return channel;
		}

		protected override void ProcessSamples(float[] data, int len)
		{
			if (base.CurrentChannel == VoiceChatChannel.Scp1576)
			{
				Scp1576Playback.DistributeSamples(base.Owner, data, len);
			}
			else
			{
				base.ProcessSamples(data, len);
			}
		}
	}
}
