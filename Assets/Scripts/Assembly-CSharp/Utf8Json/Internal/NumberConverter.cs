using System;
using Utf8Json.Internal.DoubleConversion;

namespace Utf8Json.Internal
{
	public static class NumberConverter
	{
		public static bool IsNumber(byte c)
		{
			if (48 <= c)
			{
				return c <= 57;
			}
			return false;
		}

		public static bool IsNumberRepresentation(byte c)
		{
			switch (c)
			{
			case 43:
			case 45:
			case 46:
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
				return true;
			default:
				return false;
			}
		}

		public static sbyte ReadSByte(byte[] bytes, int offset, out int readCount)
		{
			return checked((sbyte)ReadInt64(bytes, offset, out readCount));
		}

		public static short ReadInt16(byte[] bytes, int offset, out int readCount)
		{
			return checked((short)ReadInt64(bytes, offset, out readCount));
		}

		public static int ReadInt32(byte[] bytes, int offset, out int readCount)
		{
			return checked((int)ReadInt64(bytes, offset, out readCount));
		}

		public static long ReadInt64(byte[] bytes, int offset, out int readCount)
		{
			long num = 0L;
			int num2 = 1;
			if (bytes[offset] == 45)
			{
				num2 = -1;
			}
			int num3 = ((num2 == -1) ? (offset + 1) : offset);
			while (true)
			{
				if (num3 < bytes.Length)
				{
					if (!IsNumber(bytes[num3]))
					{
						readCount = num3 - offset;
						break;
					}
					num = num * 10 + (bytes[num3] - 48);
					num3++;
					continue;
				}
				readCount = bytes.Length - offset;
				break;
			}
			return num * num2;
		}

		public static byte ReadByte(byte[] bytes, int offset, out int readCount)
		{
			return checked((byte)ReadUInt64(bytes, offset, out readCount));
		}

		public static ushort ReadUInt16(byte[] bytes, int offset, out int readCount)
		{
			return checked((ushort)ReadUInt64(bytes, offset, out readCount));
		}

		public static uint ReadUInt32(byte[] bytes, int offset, out int readCount)
		{
			return checked((uint)ReadUInt64(bytes, offset, out readCount));
		}

		public static ulong ReadUInt64(byte[] bytes, int offset, out int readCount)
		{
			ulong num = 0uL;
			int num2 = offset;
			while (true)
			{
				if (num2 < bytes.Length)
				{
					if (!IsNumber(bytes[num2]))
					{
						readCount = num2 - offset;
						break;
					}
					num = checked(num * 10 + (ulong)(bytes[num2] - 48));
					num2++;
					continue;
				}
				readCount = bytes.Length - offset;
				break;
			}
			return num;
		}

		public static float ReadSingle(byte[] bytes, int offset, out int readCount)
		{
			return StringToDoubleConverter.ToSingle(bytes, offset, out readCount);
		}

		public static double ReadDouble(byte[] bytes, int offset, out int readCount)
		{
			return StringToDoubleConverter.ToDouble(bytes, offset, out readCount);
		}

		public static int WriteByte(ref byte[] buffer, int offset, byte value)
		{
			return WriteUInt64(ref buffer, offset, value);
		}

		public static int WriteUInt16(ref byte[] buffer, int offset, ushort value)
		{
			return WriteUInt64(ref buffer, offset, value);
		}

		public static int WriteUInt32(ref byte[] buffer, int offset, uint value)
		{
			return WriteUInt64(ref buffer, offset, value);
		}

		public static int WriteUInt64(ref byte[] buffer, int offset, ulong value)
		{
			int num = offset;
			ulong num2 = value;
			if (num2 < 10000)
			{
				if (num2 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
					goto IL_0488;
				}
				if (num2 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 2);
					goto IL_0463;
				}
				if (num2 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 3);
					goto IL_043e;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 4);
				goto IL_0416;
			}
			ulong num3 = num2 / 10000;
			num2 -= num3 * 10000;
			if (num3 < 10000)
			{
				if (num3 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 5);
					goto IL_0407;
				}
				if (num3 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 6);
					goto IL_03e2;
				}
				if (num3 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 7);
					goto IL_03bd;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 8);
				goto IL_0395;
			}
			ulong num4 = num3 / 10000;
			num3 -= num4 * 10000;
			if (num4 < 10000)
			{
				if (num4 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 9);
					goto IL_0386;
				}
				if (num4 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 10);
					goto IL_0361;
				}
				if (num4 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 11);
					goto IL_033c;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 12);
				goto IL_0314;
			}
			ulong num5 = num4 / 10000;
			num4 -= num5 * 10000;
			if (num5 < 10000)
			{
				if (num5 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 13);
					goto IL_0304;
				}
				if (num5 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 14);
					goto IL_02dc;
				}
				if (num5 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 15);
					goto IL_02b4;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 16);
				goto IL_0289;
			}
			ulong num6 = num5 / 10000;
			num5 -= num6 * 10000;
			if (num6 < 10000)
			{
				if (num6 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 17);
					goto IL_0279;
				}
				if (num6 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 18);
					goto IL_0251;
				}
				if (num6 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 19);
					goto IL_0229;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 20);
			}
			ulong num7;
			buffer[offset++] = (byte)(48 + (num7 = num6 * 8389 >> 23));
			num6 -= num7 * 1000;
			goto IL_0229;
			IL_0407:
			buffer[offset++] = (byte)(48 + num3);
			goto IL_0416;
			IL_0361:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 6554 >> 16));
			num4 -= num7 * 10;
			goto IL_0386;
			IL_0386:
			buffer[offset++] = (byte)(48 + num4);
			goto IL_0395;
			IL_0395:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 8389 >> 23));
			num3 -= num7 * 1000;
			goto IL_03bd;
			IL_0416:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 8389 >> 23));
			num2 -= num7 * 1000;
			goto IL_043e;
			IL_043e:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 5243 >> 19));
			num2 -= num7 * 100;
			goto IL_0463;
			IL_0463:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 6554 >> 16));
			num2 -= num7 * 10;
			goto IL_0488;
			IL_0488:
			buffer[offset++] = (byte)(48 + num2);
			return offset - num;
			IL_0314:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 8389 >> 23));
			num4 -= num7 * 1000;
			goto IL_033c;
			IL_02b4:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 5243 >> 19));
			num5 -= num7 * 100;
			goto IL_02dc;
			IL_0229:
			buffer[offset++] = (byte)(48 + (num7 = num6 * 5243 >> 19));
			num6 -= num7 * 100;
			goto IL_0251;
			IL_02dc:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 6554 >> 16));
			num5 -= num7 * 10;
			goto IL_0304;
			IL_0251:
			buffer[offset++] = (byte)(48 + (num7 = num6 * 6554 >> 16));
			num6 -= num7 * 10;
			goto IL_0279;
			IL_0304:
			buffer[offset++] = (byte)(48 + num5);
			goto IL_0314;
			IL_0279:
			buffer[offset++] = (byte)(48 + num6);
			goto IL_0289;
			IL_03bd:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 5243 >> 19));
			num3 -= num7 * 100;
			goto IL_03e2;
			IL_033c:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 5243 >> 19));
			num4 -= num7 * 100;
			goto IL_0361;
			IL_0289:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 8389 >> 23));
			num5 -= num7 * 1000;
			goto IL_02b4;
			IL_03e2:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 6554 >> 16));
			num3 -= num7 * 10;
			goto IL_0407;
		}

		public static int WriteSByte(ref byte[] buffer, int offset, sbyte value)
		{
			return WriteInt64(ref buffer, offset, value);
		}

		public static int WriteInt16(ref byte[] buffer, int offset, short value)
		{
			return WriteInt64(ref buffer, offset, value);
		}

		public static int WriteInt32(ref byte[] buffer, int offset, int value)
		{
			return WriteInt64(ref buffer, offset, value);
		}

		public static int WriteInt64(ref byte[] buffer, int offset, long value)
		{
			int num = offset;
			long num2 = value;
			if (value < 0)
			{
				if (value == long.MinValue)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 20);
					buffer[offset++] = 45;
					buffer[offset++] = 57;
					buffer[offset++] = 50;
					buffer[offset++] = 50;
					buffer[offset++] = 51;
					buffer[offset++] = 51;
					buffer[offset++] = 55;
					buffer[offset++] = 50;
					buffer[offset++] = 48;
					buffer[offset++] = 51;
					buffer[offset++] = 54;
					buffer[offset++] = 56;
					buffer[offset++] = 53;
					buffer[offset++] = 52;
					buffer[offset++] = 55;
					buffer[offset++] = 55;
					buffer[offset++] = 53;
					buffer[offset++] = 56;
					buffer[offset++] = 48;
					buffer[offset++] = 56;
					return offset - num;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
				buffer[offset++] = 45;
				num2 = -value;
			}
			if (num2 < 10000)
			{
				if (num2 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
					goto IL_059e;
				}
				if (num2 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 2);
					goto IL_0579;
				}
				if (num2 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 3);
					goto IL_0554;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 4);
				goto IL_052c;
			}
			long num3 = num2 / 10000;
			num2 -= num3 * 10000;
			if (num3 < 10000)
			{
				if (num3 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 5);
					goto IL_051d;
				}
				if (num3 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 6);
					goto IL_04f8;
				}
				if (num3 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 7);
					goto IL_04d3;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 8);
				goto IL_04ab;
			}
			long num4 = num3 / 10000;
			num3 -= num4 * 10000;
			if (num4 < 10000)
			{
				if (num4 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 9);
					goto IL_049c;
				}
				if (num4 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 10);
					goto IL_0477;
				}
				if (num4 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 11);
					goto IL_0452;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 12);
				goto IL_042a;
			}
			long num5 = num4 / 10000;
			num4 -= num5 * 10000;
			if (num5 < 10000)
			{
				if (num5 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 13);
					goto IL_041a;
				}
				if (num5 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 14);
					goto IL_03f2;
				}
				if (num5 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 15);
					goto IL_03ca;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 16);
				goto IL_039f;
			}
			long num6 = num5 / 10000;
			num5 -= num6 * 10000;
			if (num6 < 10000)
			{
				if (num6 < 10)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 17);
					goto IL_038f;
				}
				if (num6 < 100)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 18);
					goto IL_0367;
				}
				if (num6 < 1000)
				{
					BinaryUtil.EnsureCapacity(ref buffer, offset, 19);
					goto IL_033f;
				}
				BinaryUtil.EnsureCapacity(ref buffer, offset, 20);
			}
			long num7;
			buffer[offset++] = (byte)(48 + (num7 = num6 * 8389 >> 23));
			num6 -= num7 * 1000;
			goto IL_033f;
			IL_03f2:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 6554 >> 16));
			num5 -= num7 * 10;
			goto IL_041a;
			IL_039f:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 8389 >> 23));
			num5 -= num7 * 1000;
			goto IL_03ca;
			IL_051d:
			buffer[offset++] = (byte)(48 + num3);
			goto IL_052c;
			IL_03ca:
			buffer[offset++] = (byte)(48 + (num7 = num5 * 5243 >> 19));
			num5 -= num7 * 100;
			goto IL_03f2;
			IL_04d3:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 5243 >> 19));
			num3 -= num7 * 100;
			goto IL_04f8;
			IL_04ab:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 8389 >> 23));
			num3 -= num7 * 1000;
			goto IL_04d3;
			IL_04f8:
			buffer[offset++] = (byte)(48 + (num7 = num3 * 6554 >> 16));
			num3 -= num7 * 10;
			goto IL_051d;
			IL_049c:
			buffer[offset++] = (byte)(48 + num4);
			goto IL_04ab;
			IL_042a:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 8389 >> 23));
			num4 -= num7 * 1000;
			goto IL_0452;
			IL_041a:
			buffer[offset++] = (byte)(48 + num5);
			goto IL_042a;
			IL_0477:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 6554 >> 16));
			num4 -= num7 * 10;
			goto IL_049c;
			IL_052c:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 8389 >> 23));
			num2 -= num7 * 1000;
			goto IL_0554;
			IL_059e:
			buffer[offset++] = (byte)(48 + num2);
			return offset - num;
			IL_033f:
			buffer[offset++] = (byte)(48 + (num7 = num6 * 5243 >> 19));
			num6 -= num7 * 100;
			goto IL_0367;
			IL_0579:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 6554 >> 16));
			num2 -= num7 * 10;
			goto IL_059e;
			IL_0367:
			buffer[offset++] = (byte)(48 + (num7 = num6 * 6554 >> 16));
			num6 -= num7 * 10;
			goto IL_038f;
			IL_0554:
			buffer[offset++] = (byte)(48 + (num7 = num2 * 5243 >> 19));
			num2 -= num7 * 100;
			goto IL_0579;
			IL_038f:
			buffer[offset++] = (byte)(48 + num6);
			goto IL_039f;
			IL_0452:
			buffer[offset++] = (byte)(48 + (num7 = num4 * 5243 >> 19));
			num4 -= num7 * 100;
			goto IL_0477;
		}

		public static int WriteSingle(ref byte[] bytes, int offset, float value)
		{
			return DoubleToStringConverter.GetBytes(ref bytes, offset, value);
		}

		public static int WriteDouble(ref byte[] bytes, int offset, double value)
		{
			return DoubleToStringConverter.GetBytes(ref bytes, offset, value);
		}

		public static bool ReadBoolean(byte[] bytes, int offset, out int readCount)
		{
			if (bytes[offset] == 116)
			{
				if (bytes[offset + 1] == 114 && bytes[offset + 2] == 117 && bytes[offset + 3] == 101)
				{
					readCount = 4;
					return true;
				}
				throw new InvalidOperationException("value is not boolean(true).");
			}
			if (bytes[offset] == 102)
			{
				if (bytes[offset + 1] == 97 && bytes[offset + 2] == 108 && bytes[offset + 3] == 115 && bytes[offset + 4] == 101)
				{
					readCount = 5;
					return false;
				}
				throw new InvalidOperationException("value is not boolean(false).");
			}
			throw new InvalidOperationException("value is not boolean.");
		}
	}
}
