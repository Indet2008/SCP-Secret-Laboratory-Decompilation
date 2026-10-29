namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSendingVoiceMessageEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IVoiceMessageEvent
	{
		private global::VoiceChat.Networking.VoiceMessage _message;

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ref global::VoiceChat.Networking.VoiceMessage Message => ref _message;

		public bool IsAllowed { get; set; }

		public PlayerSendingVoiceMessageEventArgs(ref global::VoiceChat.Networking.VoiceMessage message)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(message.Speaker);
			_message = message;
		}
	}
}
