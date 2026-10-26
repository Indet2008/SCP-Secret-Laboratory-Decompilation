using System;

namespace VoiceChat
{
	[Flags]
	public enum VcMuteFlags : byte
	{
		None = 0,
		LocalRegular = 1,
		LocalIntercom = 2,
		GlobalRegular = 4,
		GlobalIntercom = 8
	}
}
