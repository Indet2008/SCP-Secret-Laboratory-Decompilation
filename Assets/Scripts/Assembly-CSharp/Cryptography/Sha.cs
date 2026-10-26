using System.Buffers;
using System.Security.Cryptography;
using System.Text;
using NorthwoodLib.Pools;

namespace Cryptography
{
	public static class Sha
	{
		public static byte[] Sha1(byte[] message)
		{
			using SHA1 sHA = SHA1.Create();
			return sHA.ComputeHash(message);
		}

		public static byte[] Sha1(byte[] message, int offset, int length)
		{
			using SHA1 sHA = SHA1.Create();
			return sHA.ComputeHash(message, offset, length);
		}

		public static byte[] Sha1(string message)
		{
			byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(message.Length));
			int bytes = Utf8.GetBytes(message, array);
			byte[] result = Sha1(array, 0, bytes);
			ArrayPool<byte>.Shared.Return(array);
			return result;
		}

		public static byte[] Sha256(byte[] message)
		{
			using SHA256 sHA = SHA256.Create();
			return sHA.ComputeHash(message);
		}

		public static byte[] Sha256(byte[] message, int offset, int length)
		{
			using SHA256 sHA = SHA256.Create();
			return sHA.ComputeHash(message, offset, length);
		}

		public static byte[] Sha256(string message)
		{
			byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(message.Length));
			int bytes = Utf8.GetBytes(message, array);
			byte[] result = Sha256(array, 0, bytes);
			ArrayPool<byte>.Shared.Return(array);
			return result;
		}

		public static byte[] Sha256Hmac(byte[] key, byte[] message)
		{
			using HMACSHA256 hMACSHA = new HMACSHA256(key);
			return hMACSHA.ComputeHash(message);
		}

		public static byte[] Sha512(string message)
		{
			byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(message.Length));
			int bytes = Utf8.GetBytes(message, array);
			byte[] result = Sha512(array, 0, bytes);
			ArrayPool<byte>.Shared.Return(array);
			return result;
		}

		public static byte[] Sha512(byte[] message)
		{
			using SHA512 sHA = SHA512.Create();
			return sHA.ComputeHash(message);
		}

		public static byte[] Sha512(byte[] message, int offset, int length)
		{
			using SHA512 sHA = SHA512.Create();
			return sHA.ComputeHash(message, offset, length);
		}

		public static byte[] Sha512Hmac(byte[] key, byte[] message)
		{
			using HMACSHA512 hMACSHA = new HMACSHA512(key);
			return hMACSHA.ComputeHash(message);
		}

		public static byte[] Sha512Hmac(byte[] key, string data)
		{
			byte[] array = null;
			try
			{
				array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetByteCount(data));
				int bytes = Utf8.GetBytes(data, array);
				return Sha512Hmac(key, 0, bytes, array);
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}

		public static byte[] Sha512Hmac(byte[] key, int offset, int length, byte[] message)
		{
			using HMACSHA512 hMACSHA = new HMACSHA512(key);
			return hMACSHA.ComputeHash(message, offset, length);
		}

		public static string HashToString(byte[] hash)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			foreach (byte b in hash)
			{
				stringBuilder.Append(b.ToString("X2"));
			}
			string result = stringBuilder.ToString();
			StringBuilderPool.Shared.Return(stringBuilder);
			return result;
		}
	}
}
