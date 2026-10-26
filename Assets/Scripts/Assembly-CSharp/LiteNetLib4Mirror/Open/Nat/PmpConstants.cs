namespace LiteNetLib4Mirror.Open.Nat
{
	internal static class PmpConstants
	{
		public const byte Version = 0;

		public const byte OperationExternalAddressRequest = 0;

		public const byte OperationCodeUdp = 1;

		public const byte OperationCodeTcp = 2;

		public const byte ServerNoop = 128;

		public const int ClientPort = 5350;

		public const int ServerPort = 5351;

		public const int RetryDelay = 250;

		public const int RetryAttempts = 9;

		public const int RecommendedLeaseTime = 3600;

		public const int DefaultLeaseTime = 3600;

		public const short ResultCodeSuccess = 0;

		public const short ResultCodeUnsupportedVersion = 1;

		public const short ResultCodeNotAuthorized = 2;

		public const short ResultCodeNetworkFailure = 3;

		public const short ResultCodeOutOfResources = 4;

		public const short ResultCodeUnsupportedOperationCode = 5;
	}
}
