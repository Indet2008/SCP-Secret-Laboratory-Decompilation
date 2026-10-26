using System;
using System.Runtime.InteropServices;

namespace Utf8Json.Internal
{
	[StructLayout(LayoutKind.Explicit, Pack = 1)]
	internal struct GuidBits
	{
		[FieldOffset(0)]
		public readonly Guid Value;

		[FieldOffset(0)]
		public readonly byte Byte0;

		[FieldOffset(1)]
		public readonly byte Byte1;

		[FieldOffset(2)]
		public readonly byte Byte2;

		[FieldOffset(3)]
		public readonly byte Byte3;

		[FieldOffset(4)]
		public readonly byte Byte4;

		[FieldOffset(5)]
		public readonly byte Byte5;

		[FieldOffset(6)]
		public readonly byte Byte6;

		[FieldOffset(7)]
		public readonly byte Byte7;

		[FieldOffset(8)]
		public readonly byte Byte8;

		[FieldOffset(9)]
		public readonly byte Byte9;

		[FieldOffset(10)]
		public readonly byte Byte10;

		[FieldOffset(11)]
		public readonly byte Byte11;

		[FieldOffset(12)]
		public readonly byte Byte12;

		[FieldOffset(13)]
		public readonly byte Byte13;

		[FieldOffset(14)]
		public readonly byte Byte14;

		[FieldOffset(15)]
		public readonly byte Byte15;

		private static byte[] byteToHexStringHigh = new byte[256]
		{
			48, 48, 48, 48, 48, 48, 48, 48, 48, 48,
			48, 48, 48, 48, 48, 48, 49, 49, 49, 49,
			49, 49, 49, 49, 49, 49, 49, 49, 49, 49,
			49, 49, 50, 50, 50, 50, 50, 50, 50, 50,
			50, 50, 50, 50, 50, 50, 50, 50, 51, 51,
			51, 51, 51, 51, 51, 51, 51, 51, 51, 51,
			51, 51, 51, 51, 52, 52, 52, 52, 52, 52,
			52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
			53, 53, 53, 53, 53, 53, 53, 53, 53, 53,
			53, 53, 53, 53, 53, 53, 54, 54, 54, 54,
			54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
			54, 54, 55, 55, 55, 55, 55, 55, 55, 55,
			55, 55, 55, 55, 55, 55, 55, 55, 56, 56,
			56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
			56, 56, 56, 56, 57, 57, 57, 57, 57, 57,
			57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
			97, 97, 97, 97, 97, 97, 97, 97, 97, 97,
			97, 97, 97, 97, 97, 97, 98, 98, 98, 98,
			98, 98, 98, 98, 98, 98, 98, 98, 98, 98,
			98, 98, 99, 99, 99, 99, 99, 99, 99, 99,
			99, 99, 99, 99, 99, 99, 99, 99, 100, 100,
			100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
			100, 100, 100, 100, 101, 101, 101, 101, 101, 101,
			101, 101, 101, 101, 101, 101, 101, 101, 101, 101,
			102, 102, 102, 102, 102, 102, 102, 102, 102, 102,
			102, 102, 102, 102, 102, 102
		};

		private static byte[] byteToHexStringLow = new byte[256]
		{
			48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
			97, 98, 99, 100, 101, 102, 48, 49, 50, 51,
			52, 53, 54, 55, 56, 57, 97, 98, 99, 100,
			101, 102, 48, 49, 50, 51, 52, 53, 54, 55,
			56, 57, 97, 98, 99, 100, 101, 102, 48, 49,
			50, 51, 52, 53, 54, 55, 56, 57, 97, 98,
			99, 100, 101, 102, 48, 49, 50, 51, 52, 53,
			54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
			48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
			97, 98, 99, 100, 101, 102, 48, 49, 50, 51,
			52, 53, 54, 55, 56, 57, 97, 98, 99, 100,
			101, 102, 48, 49, 50, 51, 52, 53, 54, 55,
			56, 57, 97, 98, 99, 100, 101, 102, 48, 49,
			50, 51, 52, 53, 54, 55, 56, 57, 97, 98,
			99, 100, 101, 102, 48, 49, 50, 51, 52, 53,
			54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
			48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
			97, 98, 99, 100, 101, 102, 48, 49, 50, 51,
			52, 53, 54, 55, 56, 57, 97, 98, 99, 100,
			101, 102, 48, 49, 50, 51, 52, 53, 54, 55,
			56, 57, 97, 98, 99, 100, 101, 102, 48, 49,
			50, 51, 52, 53, 54, 55, 56, 57, 97, 98,
			99, 100, 101, 102, 48, 49, 50, 51, 52, 53,
			54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
			48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
			97, 98, 99, 100, 101, 102
		};

		public GuidBits(ref Guid value)
		{
			this = default;
			Value = value;
		}

		public GuidBits(ref ArraySegment<byte> utf8string)
		{
			this = default;
			byte[] array = utf8string.Array;
			int offset = utf8string.Offset;
			if (utf8string.Count == 32)
			{
				if (BitConverter.IsLittleEndian)
				{
					Byte0 = Parse(array, offset + 6);
					Byte1 = Parse(array, offset + 4);
					Byte2 = Parse(array, offset + 2);
					Byte3 = Parse(array, offset);
					Byte4 = Parse(array, offset + 10);
					Byte5 = Parse(array, offset + 8);
					Byte6 = Parse(array, offset + 14);
					Byte7 = Parse(array, offset + 12);
				}
				else
				{
					Byte0 = Parse(array, offset);
					Byte1 = Parse(array, offset + 2);
					Byte2 = Parse(array, offset + 4);
					Byte3 = Parse(array, offset + 6);
					Byte4 = Parse(array, offset + 8);
					Byte5 = Parse(array, offset + 10);
					Byte6 = Parse(array, offset + 12);
					Byte7 = Parse(array, offset + 14);
				}
				Byte8 = Parse(array, offset + 16);
				Byte9 = Parse(array, offset + 18);
				Byte10 = Parse(array, offset + 20);
				Byte11 = Parse(array, offset + 22);
				Byte12 = Parse(array, offset + 24);
				Byte13 = Parse(array, offset + 26);
				Byte14 = Parse(array, offset + 28);
				Byte15 = Parse(array, offset + 30);
				return;
			}
			if (utf8string.Count == 36)
			{
				if (BitConverter.IsLittleEndian)
				{
					Byte0 = Parse(array, offset + 6);
					Byte1 = Parse(array, offset + 4);
					Byte2 = Parse(array, offset + 2);
					Byte3 = Parse(array, offset);
					if (array[offset + 8] == 45)
					{
						Byte4 = Parse(array, offset + 11);
						Byte5 = Parse(array, offset + 9);
						if (array[offset + 13] == 45)
						{
							Byte6 = Parse(array, offset + 16);
							Byte7 = Parse(array, offset + 14);
							goto IL_02e0;
						}
					}
				}
				else
				{
					Byte0 = Parse(array, offset);
					Byte1 = Parse(array, offset + 2);
					Byte2 = Parse(array, offset + 4);
					Byte3 = Parse(array, offset + 6);
					if (array[offset + 8] == 45)
					{
						Byte4 = Parse(array, offset + 9);
						Byte5 = Parse(array, offset + 11);
						if (array[offset + 13] == 45)
						{
							Byte6 = Parse(array, offset + 14);
							Byte7 = Parse(array, offset + 16);
							goto IL_02e0;
						}
					}
				}
			}
			goto IL_0378;
			IL_02e0:
			if (array[offset + 18] == 45)
			{
				Byte8 = Parse(array, offset + 19);
				Byte9 = Parse(array, offset + 21);
				if (array[offset + 23] == 45)
				{
					Byte10 = Parse(array, offset + 24);
					Byte11 = Parse(array, offset + 26);
					Byte12 = Parse(array, offset + 28);
					Byte13 = Parse(array, offset + 30);
					Byte14 = Parse(array, offset + 32);
					Byte15 = Parse(array, offset + 34);
					return;
				}
			}
			goto IL_0378;
			IL_0378:
			throw new ArgumentException("Invalid Guid Pattern.");
		}

		private static byte Parse(byte[] bytes, int highOffset)
		{
			return (byte)(SwitchParse(bytes[highOffset]) * 16 + SwitchParse(bytes[highOffset + 1]));
		}

		private static byte SwitchParse(byte b)
		{
			switch (b)
			{
			case 48:
			case 49:
			case 50:
			case 51:
			case 52:
			case 53:
			case 54:
			case 55:
			case 56:
			case 57:
				return (byte)(b - 48);
			case 65:
			case 66:
			case 67:
			case 68:
			case 69:
			case 70:
				return (byte)(b - 55);
			case 97:
			case 98:
			case 99:
			case 100:
			case 101:
			case 102:
				return (byte)(b - 87);
			default:
				throw new ArgumentException("Invalid Guid Pattern.");
			}
		}

		public void Write(byte[] buffer, int offset)
		{
			if (BitConverter.IsLittleEndian)
			{
				buffer[offset + 6] = byteToHexStringHigh[Byte0];
				buffer[offset + 7] = byteToHexStringLow[Byte0];
				buffer[offset + 4] = byteToHexStringHigh[Byte1];
				buffer[offset + 5] = byteToHexStringLow[Byte1];
				buffer[offset + 2] = byteToHexStringHigh[Byte2];
				buffer[offset + 3] = byteToHexStringLow[Byte2];
				buffer[offset] = byteToHexStringHigh[Byte3];
				buffer[offset + 1] = byteToHexStringLow[Byte3];
				buffer[offset + 8] = 45;
				buffer[offset + 11] = byteToHexStringHigh[Byte4];
				buffer[offset + 12] = byteToHexStringLow[Byte4];
				buffer[offset + 9] = byteToHexStringHigh[Byte5];
				buffer[offset + 10] = byteToHexStringLow[Byte5];
				buffer[offset + 13] = 45;
				buffer[offset + 16] = byteToHexStringHigh[Byte6];
				buffer[offset + 17] = byteToHexStringLow[Byte6];
				buffer[offset + 14] = byteToHexStringHigh[Byte7];
				buffer[offset + 15] = byteToHexStringLow[Byte7];
			}
			else
			{
				buffer[offset] = byteToHexStringHigh[Byte0];
				buffer[offset + 1] = byteToHexStringLow[Byte0];
				buffer[offset + 2] = byteToHexStringHigh[Byte1];
				buffer[offset + 3] = byteToHexStringLow[Byte1];
				buffer[offset + 4] = byteToHexStringHigh[Byte2];
				buffer[offset + 5] = byteToHexStringLow[Byte2];
				buffer[offset + 6] = byteToHexStringHigh[Byte3];
				buffer[offset + 7] = byteToHexStringLow[Byte3];
				buffer[offset + 8] = 45;
				buffer[offset + 9] = byteToHexStringHigh[Byte4];
				buffer[offset + 10] = byteToHexStringLow[Byte4];
				buffer[offset + 11] = byteToHexStringHigh[Byte5];
				buffer[offset + 12] = byteToHexStringLow[Byte5];
				buffer[offset + 13] = 45;
				buffer[offset + 14] = byteToHexStringHigh[Byte6];
				buffer[offset + 15] = byteToHexStringLow[Byte6];
				buffer[offset + 16] = byteToHexStringHigh[Byte7];
				buffer[offset + 17] = byteToHexStringLow[Byte7];
			}
			buffer[offset + 18] = 45;
			buffer[offset + 19] = byteToHexStringHigh[Byte8];
			buffer[offset + 20] = byteToHexStringLow[Byte8];
			buffer[offset + 21] = byteToHexStringHigh[Byte9];
			buffer[offset + 22] = byteToHexStringLow[Byte9];
			buffer[offset + 23] = 45;
			buffer[offset + 24] = byteToHexStringHigh[Byte10];
			buffer[offset + 25] = byteToHexStringLow[Byte10];
			buffer[offset + 26] = byteToHexStringHigh[Byte11];
			buffer[offset + 27] = byteToHexStringLow[Byte11];
			buffer[offset + 28] = byteToHexStringHigh[Byte12];
			buffer[offset + 29] = byteToHexStringLow[Byte12];
			buffer[offset + 30] = byteToHexStringHigh[Byte13];
			buffer[offset + 31] = byteToHexStringLow[Byte13];
			buffer[offset + 32] = byteToHexStringHigh[Byte14];
			buffer[offset + 33] = byteToHexStringLow[Byte14];
			buffer[offset + 34] = byteToHexStringHigh[Byte15];
			buffer[offset + 35] = byteToHexStringLow[Byte15];
		}
	}
}
