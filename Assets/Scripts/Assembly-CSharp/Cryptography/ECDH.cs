using System.Security.Cryptography;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Agreement;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Security;

namespace Cryptography
{
	public static class ECDH
	{
		public static AsymmetricCipherKeyPair GenerateKeys(int size = 384)
		{
			ECKeyPairGenerator eCKeyPairGenerator = new ECKeyPairGenerator("ECDH");
			KeyGenerationParameters parameters = new KeyGenerationParameters(new SecureRandom(), size);
			eCKeyPairGenerator.Init(parameters);
			return eCKeyPairGenerator.GenerateKeyPair();
		}

		public static ECDHBasicAgreement Init(AsymmetricCipherKeyPair localKey)
		{
			ECDHBasicAgreement eCDHBasicAgreement = new ECDHBasicAgreement();
			eCDHBasicAgreement.Init(localKey.Private);
			return eCDHBasicAgreement;
		}

		public static byte[] DeriveKey(ECDHBasicAgreement exchange, AsymmetricKeyParameter remoteKey)
		{
			using SHA256 sHA = SHA256.Create();
			return sHA.ComputeHash(exchange.CalculateAgreement(remoteKey).ToByteArray());
		}
	}
}
