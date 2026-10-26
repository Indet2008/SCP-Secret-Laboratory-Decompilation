using System;
using System.Reflection;

namespace Utf8Json.Internal
{
	public static class AutomataKeyGen
	{
		public unsafe static readonly MethodInfo GetKeyMethod = typeof(AutomataKeyGen).GetRuntimeMethod("GetKey", new Type[2]
		{
			typeof(byte*).MakeByRefType(),
			typeof(int).MakeByRefType()
		});

		public unsafe static ulong GetKey(ref byte* p, ref int rest)
		{
			ulong result;
			int num;
			if (rest >= 8)
			{
				result = *(ulong*)p;
				num = 8;
			}
			else
			{
				switch (rest)
				{
				case 1:
					result = *p;
					num = 1;
					break;
				case 2:
					result = *(ushort*)p;
					num = 2;
					break;
				case 3:
				{
					byte num9 = *p;
					ushort num10 = *(ushort*)(p + 1);
					result = num9 | ((ulong)num10 << 8);
					num = 3;
					break;
				}
				case 4:
					result = *(uint*)p;
					num = 4;
					break;
				case 5:
				{
					byte num7 = *p;
					uint num8 = *(uint*)(p + 1);
					result = num7 | ((ulong)num8 << 8);
					num = 5;
					break;
				}
				case 6:
				{
					long num5 = *(ushort*)p;
					ulong num6 = *(uint*)(p + 2);
					result = (ulong)num5 | (num6 << 16);
					num = 6;
					break;
				}
				case 7:
				{
					byte num2 = *p;
					ushort num3 = *(ushort*)(p + 1);
					uint num4 = *(uint*)(p + 3);
					result = num2 | ((ulong)num3 << 8) | ((ulong)num4 << 24);
					num = 7;
					break;
				}
				default:
					throw new InvalidOperationException("Not Supported Length");
				}
			}
			p += num;
			rest -= num;
			return result;
		}

		public static ulong GetKeySafe(byte[] bytes, ref int offset, ref int rest)
		{
			ulong result;
			int num;
			if (BitConverter.IsLittleEndian)
			{
				if (rest >= 8)
				{
					result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 24) | ((ulong)bytes[offset + 4] << 32) | ((ulong)bytes[offset + 5] << 40) | ((ulong)bytes[offset + 6] << 48) | ((ulong)bytes[offset + 7] << 56);
					num = 8;
				}
				else
				{
					switch (rest)
					{
					case 1:
						result = bytes[offset];
						num = 1;
						break;
					case 2:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8);
						num = 2;
						break;
					case 3:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16);
						num = 3;
						break;
					case 4:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 24);
						num = 4;
						break;
					case 5:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 24) | ((ulong)bytes[offset + 4] << 32);
						num = 5;
						break;
					case 6:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 24) | ((ulong)bytes[offset + 4] << 32) | ((ulong)bytes[offset + 5] << 40);
						num = 6;
						break;
					case 7:
						result = bytes[offset] | ((ulong)bytes[offset + 1] << 8) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 24) | ((ulong)bytes[offset + 4] << 32) | ((ulong)bytes[offset + 5] << 40) | ((ulong)bytes[offset + 6] << 48);
						num = 7;
						break;
					default:
						throw new InvalidOperationException("Not Supported Length");
					}
				}
				offset += num;
				rest -= num;
				return result;
			}
			if (rest >= 8)
			{
				result = ((ulong)bytes[offset] << 56) | ((ulong)bytes[offset + 1] << 48) | ((ulong)bytes[offset + 2] << 40) | ((ulong)bytes[offset + 3] << 32) | ((ulong)bytes[offset + 4] << 24) | ((ulong)bytes[offset + 5] << 16) | ((ulong)bytes[offset + 6] << 8) | bytes[offset + 7];
				num = 8;
			}
			else
			{
				switch (rest)
				{
				case 1:
					result = bytes[offset];
					num = 1;
					break;
				case 2:
					result = ((ulong)bytes[offset] << 8) | bytes[offset + 1];
					num = 2;
					break;
				case 3:
					result = ((ulong)bytes[offset] << 16) | ((ulong)bytes[offset + 1] << 8) | bytes[offset + 2];
					num = 3;
					break;
				case 4:
					result = ((ulong)bytes[offset] << 24) | ((ulong)bytes[offset + 1] << 16) | ((ulong)bytes[offset + 2] << 8) | bytes[offset + 3];
					num = 4;
					break;
				case 5:
					result = ((ulong)bytes[offset] << 32) | ((ulong)bytes[offset + 1] << 24) | ((ulong)bytes[offset + 2] << 16) | ((ulong)bytes[offset + 3] << 8) | bytes[offset + 4];
					num = 5;
					break;
				case 6:
					result = ((ulong)bytes[offset] << 40) | ((ulong)bytes[offset + 1] << 32) | ((ulong)bytes[offset + 2] << 24) | ((ulong)bytes[offset + 3] << 16) | ((ulong)bytes[offset + 4] << 8) | bytes[offset + 5];
					num = 6;
					break;
				case 7:
					result = ((ulong)bytes[offset] << 48) | ((ulong)bytes[offset + 1] << 40) | ((ulong)bytes[offset + 2] << 32) | ((ulong)bytes[offset + 3] << 24) | ((ulong)bytes[offset + 4] << 16) | ((ulong)bytes[offset + 5] << 8) | bytes[offset + 6];
					num = 7;
					break;
				default:
					throw new InvalidOperationException("Not Supported Length");
				}
			}
			offset += num;
			rest -= num;
			return result;
		}
	}
}
