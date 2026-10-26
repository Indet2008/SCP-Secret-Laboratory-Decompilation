using System;

namespace VoiceChat
{
	[Flags]
	public enum VcPrivacyFlags : byte
	{
		None = 0,
		SettingsSelected = 1,
		AllowMicCapture = 2,
		AllowRecording = 4
	}
}
