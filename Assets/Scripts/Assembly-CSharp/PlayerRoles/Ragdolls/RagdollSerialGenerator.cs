namespace PlayerRoles.Ragdolls
{
	public static class RagdollSerialGenerator
	{
		private static ushort _lastGenerated = 0;

		private static readonly object Lock = new object();

		public static ushort GenerateNext()
		{
			lock (Lock)
			{
				int num = _lastGenerated + 1;
				if (num > 65535)
				{
					num = 1;
				}
				_lastGenerated = (ushort)num;
				return _lastGenerated;
			}
		}
	}
}
