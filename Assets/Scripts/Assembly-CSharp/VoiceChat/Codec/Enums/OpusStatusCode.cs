namespace VoiceChat.Codec.Enums
{
	public enum OpusStatusCode
	{
		OK = 0,
		BadArguments = -1,
		BufferTooSmall = -2,
		InternalError = -3,
		InvalidPacket = -4,
		Unimplemented = -5,
		InvalidState = -6,
		AllocFail = -7
	}
}
