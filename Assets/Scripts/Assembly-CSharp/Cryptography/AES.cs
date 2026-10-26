using System;
using System.Buffers;
using Org.BouncyCastle.Crypto.Engines;
using Org.BouncyCastle.Crypto.Modes;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Security;

namespace Cryptography
{
	public static class AES
	{
		public const int NonceSizeBytes = 32;

		private const int MacSizeBits = 128;

		public static void GenerateNonce(byte[] buffer, SecureRandom secureRandom)
		{
			secureRandom.NextBytes(buffer, 0, 32);
		}

		public static void ReadNonce(byte[] buffer, byte[] cipherText, int dataOffset = 0)
		{
			Array.Copy(cipherText, dataOffset, buffer, 0, 32);
		}

		public static GcmBlockCipher AesGcmEncryptInit(int dataLength, byte[] secret, byte[] nonce, out int outputSize)
		{
			GcmBlockCipher gcmBlockCipher = new GcmBlockCipher(new AesEngine());
			gcmBlockCipher.Init(forEncryption: true, new AeadParameters(new KeyParameter(secret), 128, nonce));
			outputSize = gcmBlockCipher.GetOutputSize(dataLength) + 32;
			return gcmBlockCipher;
		}

		public static void AesGcmEncrypt(GcmBlockCipher cipher, byte[] nonce, byte[] data, int dataOffset, int dataLength, byte[] cipherText, int cipherTextOffset)
		{
			int num = cipher.ProcessBytes(data, dataOffset, dataLength, cipherText, cipherTextOffset + 32);
			cipher.DoFinal(cipherText, num + cipherTextOffset + 32);
			Array.Copy(nonce, 0, cipherText, cipherTextOffset, 32);
		}

		public static byte[] AesGcmEncrypt(byte[] data, byte[] secret, SecureRandom secureRandom, int dataOffset = 0, int dataLength = 0)
		{
			if (dataLength == 0)
			{
				dataLength = data.Length;
			}
			byte[] array = ArrayPool<byte>.Shared.Rent(32);
			try
			{
				secureRandom.NextBytes(array, 0, array.Length);
				GcmBlockCipher gcmBlockCipher = new GcmBlockCipher(new AesEngine());
				gcmBlockCipher.Init(forEncryption: true, new AeadParameters(new KeyParameter(secret), 128, array));
				byte[] array2 = new byte[gcmBlockCipher.GetOutputSize(data.Length) + 32];
				int num = gcmBlockCipher.ProcessBytes(data, dataOffset, dataLength, array2, 32);
				gcmBlockCipher.DoFinal(array2, num + 32);
				Array.Copy(array, array2, 32);
				return array2;
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}

		public static GcmBlockCipher AesGcmDecryptInit(byte[] nonce, byte[] secret, int cipherTextLength, out int outputSize)
		{
			GcmBlockCipher gcmBlockCipher = new GcmBlockCipher(new AesEngine());
			gcmBlockCipher.Init(forEncryption: false, new AeadParameters(new KeyParameter(secret), 128, nonce));
			outputSize = gcmBlockCipher.GetOutputSize(cipherTextLength - 32);
			return gcmBlockCipher;
		}

		public static void AesGcmDecrypt(GcmBlockCipher cipher, byte[] cipherText, byte[] plainText, int cipherTextOffset = 0, int cipherTextLength = 0, int plainTextOffset = 0)
		{
			if (cipherTextLength == 0)
			{
				cipherTextLength = cipherText.Length;
			}
			int num = cipher.ProcessBytes(cipherText, cipherTextOffset + 32, cipherTextLength - 32, plainText, plainTextOffset);
			cipher.DoFinal(plainText, plainTextOffset + num);
		}

		public static byte[] AesGcmDecrypt(byte[] data, byte[] secret, int dataOffset = 0, int dataLength = 0)
		{
			if (dataLength <= 0)
			{
				dataLength = data.Length;
			}
			if (dataLength < 32)
			{
				throw new ArgumentException("Data length can't be smaller than nonce size.", "dataLength");
			}
			byte[] array = ArrayPool<byte>.Shared.Rent(32);
			try
			{
				Array.Copy(data, dataOffset, array, 0, 32);
				GcmBlockCipher gcmBlockCipher = new GcmBlockCipher(new AesEngine());
				gcmBlockCipher.Init(forEncryption: false, new AeadParameters(new KeyParameter(secret), 128, array));
				int len = dataLength - 32;
				byte[] array2 = new byte[gcmBlockCipher.GetOutputSize(len)];
				int outOff = gcmBlockCipher.ProcessBytes(data, dataOffset + 32, len, array2, 0);
				gcmBlockCipher.DoFinal(array2, outOff);
				return array2;
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
	}
}
