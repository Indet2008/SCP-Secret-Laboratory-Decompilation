using System;

namespace Utf8Json.Internal
{
	public static class BinaryUtil
	{
		private const int ArrayMaxSize = 2147483591;

		public static void EnsureCapacity(ref byte[] bytes, int offset, int appendLength)
		{
			int num = offset + appendLength;
			if (bytes == null)
			{
				bytes = new byte[num];
				return;
			}
			int num2 = bytes.Length;
			if (num <= num2)
			{
				return;
			}
			int num3 = num;
			if (num3 < 256)
			{
				num3 = 256;
				FastResize(ref bytes, num3);
				return;
			}
			if (num2 == 2147483591)
			{
				throw new InvalidOperationException("byte[] size reached maximum size of array(0x7FFFFFC7), can not write to single byte[]. Details: https://msdn.microsoft.com/en-us/library/system.array");
			}
			int num4 = num2 * 2;
			if (num4 < 0)
			{
				num3 = 2147483591;
			}
			else if (num3 < num4)
			{
				num3 = num4;
			}
			FastResize(ref bytes, num3);
		}

		public static void FastResize(ref byte[] array, int newSize)
		{
			if (newSize < 0)
			{
				throw new ArgumentOutOfRangeException("newSize");
			}
			byte[] array2 = array;
			if (array2 == null)
			{
				array = new byte[newSize];
			}
			else if (array2.Length != newSize)
			{
				byte[] array3 = new byte[newSize];
				Buffer.BlockCopy(array2, 0, array3, 0, (array2.Length > newSize) ? newSize : array2.Length);
				array = array3;
			}
		}

		public static byte[] FastCloneWithResize(byte[] src, int newSize)
		{
			if (newSize < 0)
			{
				throw new ArgumentOutOfRangeException("newSize");
			}
			if (src.Length < newSize)
			{
				throw new ArgumentException("length < newSize");
			}
			if (src == null)
			{
				return new byte[newSize];
			}
			byte[] array = new byte[newSize];
			Buffer.BlockCopy(src, 0, array, 0, newSize);
			return array;
		}
	}
}
