using UnityEngine;
using VoiceChat;

namespace PlayerRoles.Spectating
{
	public class OverwatchVoiceChatButton : OverwatchToggleButton
	{
		[Tooltip("The voice channel that will be toggled with the button.")]
		public VoiceChatChannel VoiceChatChannel;

		public bool DefaultState = true;

		private void Start()
		{
			base.IsToggled = DefaultState;
		}
	}
}
