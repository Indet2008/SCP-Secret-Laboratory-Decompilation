using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace LiteNetLib.Utils
{
	public static class FastBitConverter
	{
		[StructLayout(LayoutKind.Explicit)]
		private struct ConverterHelperDouble
		{
			[FieldOffset(0)]
			public ulong Along;

			[FieldOffset(0)]
			public double Adouble;
		}

		[StructLayout(LayoutKind.Explicit)]
		private struct ConverterHelperFloat
		{
			[FieldOffset(0)]
			public int Aint;

			[FieldOffset(0)]
			public float Afloat;
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		private static void WriteLittleEndian(byte[] buffer, int offset, ulong data)
		{
			buffer[offset] = (byte)data;
			buffer[offset + 1] = (byte)(data >> 8);
			buffer[offset + 2] = (byte)(data >> 16);
			buffer[offset + 3] = (byte)(data >> 24);
			buffer[offset + 4] = (byte)(data >> 32);
			buffer[offset + 5] = (byte)(data >> 40);
			buffer[offset + 6] = (byte)(data >> 48);
			buffer[offset + 7] = (byte)(data >> 56);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		private static void WriteLittleEndian(byte[] buffer, int offset, int data)
		{
			buffer[offset] = (byte)data;
			buffer[offset + 1] = (byte)(data >> 8);
			buffer[offset + 2] = (byte)(data >> 16);
			buffer[offset + 3] = (byte)(data >> 24);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void WriteLittleEndian(byte[] buffer, int offset, short data)
		{
			buffer[offset] = (byte)data;
			buffer[offset + 1] = (byte)(data >> 8);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, double value)
		{
			ConverterHelperDouble converterHelperDouble = new ConverterHelperDouble
			{
				Adouble = value
			};
			WriteLittleEndian(bytes, startIndex, converterHelperDouble.Along);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, float value)
		{
			ConverterHelperFloat converterHelperFloat = new ConverterHelperFloat
			{
				Afloat = value
			};
			WriteLittleEndian(bytes, startIndex, converterHelperFloat.Aint);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, short value)
		{
			WriteLittleEndian(bytes, startIndex, value);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, ushort value)
		{
			WriteLittleEndian(bytes, startIndex, (short)value);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, int value)
		{
			WriteLittleEndian(bytes, startIndex, value);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, uint value)
		{
			WriteLittleEndian(bytes, startIndex, (int)value);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, long value)
		{
			WriteLittleEndian(bytes, startIndex, (ulong)value);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void GetBytes(byte[] bytes, int startIndex, ulong value)
		{
			WriteLittleEndian(bytes, startIndex, value);
		}
	}
}
