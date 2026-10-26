using System;
using System.Buffers;
using System.IO;
using System.Text;
using GameCore;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.OpenSsl;
using Org.BouncyCastle.Security;
using UnityEngine;

namespace Cryptography
{
	public static class ECDSA
	{
		public static AsymmetricCipherKeyPair GenerateKeys(int size = 384)
		{
			ECKeyPairGenerator eCKeyPairGenerator = new ECKeyPairGenerator("ECDSA");
			KeyGenerationParameters parameters = new KeyGenerationParameters(new SecureRandom(), size);
			eCKeyPairGenerator.Init(parameters);
			return eCKeyPairGenerator.GenerateKeyPair();
		}

		public static string Sign(string data, AsymmetricKeyParameter privKey)
		{
			return Convert.ToBase64String(SignBytes(data, privKey));
		}

		public static byte[] SignBytes(string data, AsymmetricKeyParameter privKey)
		{
			try
			{
				byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(data.Length));
				int bytes = Utf8.GetBytes(data, array);
				byte[] result = SignBytes(array, 0, bytes, privKey);
				ArrayPool<byte>.Shared.Return(array);
				return result;
			}
			catch
			{
				return null;
			}
		}

		public static byte[] SignBytes(byte[] data, AsymmetricKeyParameter privKey)
		{
			return SignBytes(data, 0, data.Length, privKey);
		}

		public static byte[] SignBytes(byte[] data, int offset, int count, AsymmetricKeyParameter privKey)
		{
			try
			{
				ISigner signer = SignerUtilities.GetSigner("SHA-256withECDSA");
				signer.Init(forSigning: true, privKey);
				signer.BlockUpdate(data, offset, count);
				return signer.GenerateSignature();
			}
			catch
			{
				return null;
			}
		}

		public static bool Verify(string data, string signature, AsymmetricKeyParameter pubKey)
		{
			return VerifyBytes(data, Convert.FromBase64String(signature), pubKey);
		}

		public static bool VerifyBytes(string data, byte[] signature, AsymmetricKeyParameter pubKey)
		{
			try
			{
				ISigner signer = SignerUtilities.GetSigner("SHA-256withECDSA");
				signer.Init(forSigning: false, pubKey);
				byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(data.Length));
				int bytes = Utf8.GetBytes(data, array);
				signer.BlockUpdate(array, 0, bytes);
				ArrayPool<byte>.Shared.Return(array);
				return signer.VerifySignature(signature);
			}
			catch (Exception ex)
			{
				GameCore.Console.AddLog("ECDSA Verification Error (BouncyCastle): " + ex.Message + ", " + ex.StackTrace, Color.red);
				return false;
			}
		}

		public static AsymmetricKeyParameter PublicKeyFromString(string key)
		{
			if (string.IsNullOrEmpty(key))
			{
				return null;
			}
			using TextReader reader = new StringReader(key);
			return (AsymmetricKeyParameter)new PemReader(reader).ReadObject();
		}

		public static AsymmetricKeyParameter PrivateKeyFromString(string key)
		{
			using TextReader reader = new StringReader(key);
			return ((AsymmetricCipherKeyPair)new PemReader(reader).ReadObject()).Private;
		}

		public static string KeyToString(AsymmetricKeyParameter key)
		{
			using TextWriter textWriter = new StringWriter();
			PemWriter pemWriter = new PemWriter(textWriter);
			pemWriter.WriteObject(key);
			pemWriter.Writer.Flush();
			return textWriter.ToString();
		}
	}
}
