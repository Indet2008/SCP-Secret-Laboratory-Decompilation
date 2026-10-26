using System.Buffers;
using System.Security.Cryptography;
using System.Text;

namespace Cryptography
{
	public static class Md
	{
		public static byte[] Md5(byte[] message)
		{
			using MD5 mD = MD5.Create();
			return mD.ComputeHash(message);
		}

		public static byte[] Md5(byte[] message, int offset, int length)
		{
			using MD5 mD = MD5.Create();
			return mD.ComputeHash(message, offset, length);
		}

		public static byte[] Md5(string message)
		{
			byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(message.Length));
			int bytes = Utf8.GetBytes(message, array);
			byte[] result = Md5(array, 0, bytes);
			ArrayPool<byte>.Shared.Return(array);
			return result;
		}
	}
}
