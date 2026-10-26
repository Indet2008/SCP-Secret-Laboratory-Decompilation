namespace Mirror
{
	public static class Compression
	{
		private const float QuaternionMinRange = -0.707107f;

		private const float QuaternionMaxRange = 0.707107f;

		private const ushort TenBitsMax = 1023;

		public static bool ScaleToLong(float value, float precision, out long result)
		{
			if (precision == 0f)
			{
				throw new global::System.DivideByZeroException("ScaleToLong: precision=0 would cause null division. If rounding isn't wanted, don't call this function.");
			}
			try
			{
				result = global::System.Convert.ToInt64(value / precision);
				return true;
			}
			catch (global::System.OverflowException)
			{
				result = ((value > 0f) ? long.MaxValue : long.MinValue);
				return false;
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool ScaleToLong(global::UnityEngine.Vector3 value, float precision, out long x, out long y, out long z)
		{
			return (byte)(1u & (ScaleToLong(value.x, precision, out x) ? 1u : 0u) & (ScaleToLong(value.y, precision, out y) ? 1u : 0u) & (ScaleToLong(value.z, precision, out z) ? 1u : 0u)) != 0;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool ScaleToLong(global::UnityEngine.Vector3 value, float precision, out global::Mirror.Vector3Long quantized)
		{
			quantized = global::Mirror.Vector3Long.zero;
			return ScaleToLong(value, precision, out quantized.x, out quantized.y, out quantized.z);
		}

		public static float ScaleToFloat(long value, float precision)
		{
			if (precision == 0f)
			{
				throw new global::System.DivideByZeroException("ScaleToLong: precision=0 would cause null division. If rounding isn't wanted, don't call this function.");
			}
			return (float)value * precision;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::UnityEngine.Vector3 ScaleToFloat(long x, long y, long z, float precision)
		{
			global::UnityEngine.Vector3 result = default;
			result.x = ScaleToFloat(x, precision);
			result.y = ScaleToFloat(y, precision);
			result.z = ScaleToFloat(z, precision);
			return result;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::UnityEngine.Vector3 ScaleToFloat(global::Mirror.Vector3Long value, float precision)
		{
			return ScaleToFloat(value.x, value.y, value.z, precision);
		}

		public static ushort ScaleFloatToUShort(float value, float minValue, float maxValue, ushort minTarget, ushort maxTarget)
		{
			int num = maxTarget - minTarget;
			float num2 = maxValue - minValue;
			float num3 = value - minValue;
			return (ushort)(minTarget + (ushort)(num3 / num2 * (float)num));
		}

		public static float ScaleUShortToFloat(ushort value, ushort minValue, ushort maxValue, float minTarget, float maxTarget)
		{
			float num = maxTarget - minTarget;
			ushort num2 = (ushort)(maxValue - minValue);
			ushort num3 = (ushort)(value - minValue);
			return minTarget + (float)(int)num3 / (float)(int)num2 * num;
		}

		public static int LargestAbsoluteComponentIndex(global::UnityEngine.Vector4 value, out float largestAbs, out global::UnityEngine.Vector3 withoutLargest)
		{
			global::UnityEngine.Vector4 vector = new global::UnityEngine.Vector4(global::UnityEngine.Mathf.Abs(value.x), global::UnityEngine.Mathf.Abs(value.y), global::UnityEngine.Mathf.Abs(value.z), global::UnityEngine.Mathf.Abs(value.w));
			largestAbs = vector.x;
			withoutLargest = new global::UnityEngine.Vector3(value.y, value.z, value.w);
			int result = 0;
			if (vector.y > largestAbs)
			{
				result = 1;
				largestAbs = vector.y;
				withoutLargest = new global::UnityEngine.Vector3(value.x, value.z, value.w);
			}
			if (vector.z > largestAbs)
			{
				result = 2;
				largestAbs = vector.z;
				withoutLargest = new global::UnityEngine.Vector3(value.x, value.y, value.w);
			}
			if (vector.w > largestAbs)
			{
				result = 3;
				largestAbs = vector.w;
				withoutLargest = new global::UnityEngine.Vector3(value.x, value.y, value.z);
			}
			return result;
		}

		public static uint CompressQuaternion(global::UnityEngine.Quaternion q)
		{
			int num = LargestAbsoluteComponentIndex(new global::UnityEngine.Vector4(q.x, q.y, q.z, q.w), out var _, out var withoutLargest);
			if (q[num] < 0f)
			{
				withoutLargest = -withoutLargest;
			}
			ushort num2 = ScaleFloatToUShort(withoutLargest.x, -0.707107f, 0.707107f, 0, 1023);
			ushort num3 = ScaleFloatToUShort(withoutLargest.y, -0.707107f, 0.707107f, 0, 1023);
			ushort num4 = ScaleFloatToUShort(withoutLargest.z, -0.707107f, 0.707107f, 0, 1023);
			return (uint)((num << 30) | (num2 << 20) | (num3 << 10) | num4);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		private static global::UnityEngine.Quaternion QuaternionNormalizeSafe(global::UnityEngine.Quaternion value)
		{
			global::UnityEngine.Vector4 vector = new global::UnityEngine.Vector4(value.x, value.y, value.z, value.w);
			if (!(global::UnityEngine.Vector4.Dot(vector, vector) > 1.1754944E-38f))
			{
				return global::UnityEngine.Quaternion.identity;
			}
			return value.normalized;
		}

		public static global::UnityEngine.Quaternion DecompressQuaternion(uint data)
		{
			ushort value = (ushort)(data & 0x3FF);
			ushort value2 = (ushort)((data >> 10) & 0x3FF);
			ushort value3 = (ushort)((data >> 20) & 0x3FF);
			int num = (int)(data >> 30);
			float num2 = ScaleUShortToFloat(value3, 0, 1023, -0.707107f, 0.707107f);
			float num3 = ScaleUShortToFloat(value2, 0, 1023, -0.707107f, 0.707107f);
			float num4 = ScaleUShortToFloat(value, 0, 1023, -0.707107f, 0.707107f);
			float num5 = global::UnityEngine.Mathf.Sqrt(1f - num2 * num2 - num3 * num3 - num4 * num4);
			global::UnityEngine.Vector4 vector = num switch
			{
				0 => new global::UnityEngine.Vector4(num5, num2, num3, num4), 
				1 => new global::UnityEngine.Vector4(num2, num5, num3, num4), 
				2 => new global::UnityEngine.Vector4(num2, num3, num5, num4), 
				_ => new global::UnityEngine.Vector4(num2, num3, num4, num5), 
			};
			return QuaternionNormalizeSafe(new global::UnityEngine.Quaternion(vector.x, vector.y, vector.z, vector.w));
		}

		public static int VarUIntSize(ulong value)
		{
			if (value <= 240)
			{
				return 1;
			}
			if (value <= 2287)
			{
				return 2;
			}
			if (value <= 67823)
			{
				return 3;
			}
			if (value <= 16777215)
			{
				return 4;
			}
			if (value <= uint.MaxValue)
			{
				return 5;
			}
			if (value <= 1099511627775L)
			{
				return 6;
			}
			if (value <= 281474976710655L)
			{
				return 7;
			}
			if (value <= 72057594037927935L)
			{
				return 8;
			}
			return 9;
		}

		public static int VarIntSize(long value)
		{
			return VarUIntSize((ulong)((value >> 63) ^ (value << 1)));
		}

		public static void CompressVarUInt(global::Mirror.NetworkWriter writer, ulong value)
		{
			if (value <= 240)
			{
				byte value2 = (byte)value;
				writer.WriteByte(value2);
			}
			else if (value <= 2287)
			{
				byte b = (byte)((value - 240 >> 8) + 241);
				byte b2 = (byte)((value - 240) & 0xFF);
				writer.WriteUShort((ushort)((b2 << 8) | b));
			}
			else if (value <= 67823)
			{
				byte value3 = 249;
				byte b3 = (byte)(value - 2288 >> 8);
				byte b4 = (byte)((value - 2288) & 0xFF);
				writer.WriteByte(value3);
				writer.WriteUShort((ushort)((b4 << 8) | b3));
			}
			else if (value <= 16777215)
			{
				byte b5 = 250;
				uint num = (uint)(value << 8);
				writer.WriteUInt(num | b5);
			}
			else if (value <= uint.MaxValue)
			{
				byte value4 = 251;
				uint value5 = (uint)value;
				writer.WriteByte(value4);
				writer.WriteUInt(value5);
			}
			else if (value <= 1099511627775L)
			{
				byte b6 = 252;
				byte b7 = (byte)(value & 0xFF);
				uint value6 = (uint)(value >> 8);
				writer.WriteUShort((ushort)((b7 << 8) | b6));
				writer.WriteUInt(value6);
			}
			else if (value <= 281474976710655L)
			{
				byte value7 = 253;
				byte b8 = (byte)(value & 0xFF);
				byte b9 = (byte)((value >> 8) & 0xFF);
				uint value8 = (uint)(value >> 16);
				writer.WriteByte(value7);
				writer.WriteUShort((ushort)((b9 << 8) | b8));
				writer.WriteUInt(value8);
			}
			else if (value <= 72057594037927935L)
			{
				byte b10 = 254;
				ulong num2 = value << 8;
				writer.WriteULong(num2 | b10);
			}
			else
			{
				writer.WriteByte(byte.MaxValue);
				writer.WriteULong(value);
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void CompressVarInt(global::Mirror.NetworkWriter writer, long i)
		{
			ulong value = (ulong)((i >> 63) ^ (i << 1));
			CompressVarUInt(writer, value);
		}

		public static ulong DecompressVarUInt(global::Mirror.NetworkReader reader)
		{
			byte b = reader.ReadByte();
			if (b < 241)
			{
				return b;
			}
			byte b2 = reader.ReadByte();
			if (b <= 248)
			{
				return (ulong)(240 + ((long)b - 241L << 8) + b2);
			}
			byte b3 = reader.ReadByte();
			if (b == 249)
			{
				return 2288 + ((ulong)b2 << 8) + b3;
			}
			byte b4 = reader.ReadByte();
			if (b == 250)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16);
			}
			byte b5 = reader.ReadByte();
			if (b == 251)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16) + ((ulong)b5 << 24);
			}
			byte b6 = reader.ReadByte();
			if (b == 252)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16) + ((ulong)b5 << 24) + ((ulong)b6 << 32);
			}
			byte b7 = reader.ReadByte();
			if (b == 253)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16) + ((ulong)b5 << 24) + ((ulong)b6 << 32) + ((ulong)b7 << 40);
			}
			byte b8 = reader.ReadByte();
			if (b == 254)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16) + ((ulong)b5 << 24) + ((ulong)b6 << 32) + ((ulong)b7 << 40) + ((ulong)b8 << 48);
			}
			byte b9 = reader.ReadByte();
			if (b == byte.MaxValue)
			{
				return b2 + ((ulong)b3 << 8) + ((ulong)b4 << 16) + ((ulong)b5 << 24) + ((ulong)b6 << 32) + ((ulong)b7 << 40) + ((ulong)b8 << 48) + ((ulong)b9 << 56);
			}
			throw new global::System.IndexOutOfRangeException($"DecompressVarInt failure: {b}");
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static long DecompressVarInt(global::Mirror.NetworkReader reader)
		{
			ulong num = DecompressVarUInt(reader);
			return (long)((num >> 1) ^ (0L - (num & 1)));
		}
	}
}
