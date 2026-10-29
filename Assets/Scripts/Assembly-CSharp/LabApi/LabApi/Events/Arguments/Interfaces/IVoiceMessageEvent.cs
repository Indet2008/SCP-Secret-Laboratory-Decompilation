namespace LabApi.Events.Arguments.Interfaces
{
	public interface IVoiceMessageEvent
	{
		ref global::VoiceChat.Networking.VoiceMessage Message { get; }
	}
}
