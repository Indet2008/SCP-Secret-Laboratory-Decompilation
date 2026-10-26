namespace LiteNetLib.Utils
{
	public static class CRC32C
	{
		public const int ChecksumSize = 4;

		private const uint Poly = 2197175160u;

		private static readonly uint[] Table;

		static CRC32C()
		{
			Table = NetUtils.AllocatePinnedUninitializedArray<uint>(4096);
			for (uint num = 0u; num < 256; num++)
			{
				uint num2 = num;
				for (int i = 0; i < 16; i++)
				{
					for (int j = 0; j < 8; j++)
					{
						num2 = (((num2 & 1) == 1) ? (0x82F63B78u ^ (num2 >> 1)) : (num2 >> 1));
					}
					Table[i * 256 + num] = num2;
				}
			}
		}

		public static uint Compute(byte[] input, int offset, int length)
		{
			uint num = uint.MaxValue;
			while (length >= 16)
			{
				uint num2 = Table[768 + input[offset + 12]] ^ Table[512 + input[offset + 13]] ^ Table[256 + input[offset + 14]] ^ Table[input[offset + 15]];
				uint num3 = Table[1792 + input[offset + 8]] ^ Table[1536 + input[offset + 9]] ^ Table[1280 + input[offset + 10]] ^ Table[1024 + input[offset + 11]];
				uint num4 = Table[2816 + input[offset + 4]] ^ Table[2560 + input[offset + 5]] ^ Table[2304 + input[offset + 6]] ^ Table[2048 + input[offset + 7]];
				num = Table[3840 + ((byte)num ^ input[offset])] ^ Table[3584 + ((byte)(num >> 8) ^ input[offset + 1])] ^ Table[3328 + ((byte)(num >> 16) ^ input[offset + 2])] ^ Table[3072 + ((num >> 24) ^ input[offset + 3])] ^ num4 ^ num3 ^ num2;
				offset += 16;
				length -= 16;
			}
			while (--length >= 0)
			{
				num = Table[(byte)(num ^ input[offset++])] ^ (num >> 8);
			}
			return num ^ 0xFFFFFFFFu;
		}
	}
}
