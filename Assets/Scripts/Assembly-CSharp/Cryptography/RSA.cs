using System;
using System.Buffers;
using System.IO;
using System.Text;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.OpenSsl;
using Org.BouncyCastle.Security;

namespace Cryptography
{
	public static class RSA
	{
		public static bool Verify(string data, string signature, string key)
		{
			using TextReader reader = new StringReader(key);
			AsymmetricKeyParameter parameters = (AsymmetricKeyParameter)new PemReader(reader).ReadObject();
			ISigner signer = SignerUtilities.GetSigner("SHA256withRSA");
			signer.Init(forSigning: false, parameters);
			byte[] signature2 = Convert.FromBase64String(signature);
			byte[] array = ArrayPool<byte>.Shared.Rent(Encoding.UTF8.GetMaxByteCount(data.Length));
			int bytes = Utf8.GetBytes(data, array);
			signer.BlockUpdate(array, 0, bytes);
			ArrayPool<byte>.Shared.Return(array);
			return signer.VerifySignature(signature2);
		}
	}
}
