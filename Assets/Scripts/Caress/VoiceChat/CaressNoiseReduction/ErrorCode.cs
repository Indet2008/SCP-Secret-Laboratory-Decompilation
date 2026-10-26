namespace VoiceChat.CaressNoiseReduction
{
	public enum ErrorCode : byte
	{
		CaressOk = 1,
		ErrorInitialize = 2,
		ErrorUnInitialized = 3,
		ErrorNoDataSupplied = 4,
		ErrorNoTargetBuffer = 5,
		ErrorSuppliedDataSize = 6,
		ErrorEncode = 7,
		ErrorDecode = 8,
		ErrorSetBitrate = 9,
		ErrorGetBitrate = 10,
		ErrorSetBitrateInvalidSize = 11,
		ErrorSetComplexity = 12,
		ErrorSetComplexityInvalidSize = 13,
		ErrorGetComplexity = 14,
		ErrorSetSignal = 15,
		ErrorSetSignalInvalidValue = 16,
		ErrorGetSignal = 17,
		ErrorSetInBandFec = 18,
		ErrorGetInBandFec = 19,
		ErrorSetPacketLossPerc = 20,
		ErrorSetPacketLossPercInvalidValue = 21,
		ErrorGetPacketLossPerc = 22,
		ErrorUnDefined = 23
	}
}
