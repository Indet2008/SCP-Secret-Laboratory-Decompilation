using System;
using VoiceChat.Codec.Enums;

namespace VoiceChat.Codec
{
	public class OpusException : Exception
	{
		public readonly OpusStatusCode StatusCode;

		public OpusException(OpusStatusCode statusCode, string message)
			: base(message)
		{
			StatusCode = statusCode;
		}
	}
}
