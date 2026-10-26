using System;
using Cryptography;
using GameCore;
using Mirror;
using NorthwoodLib;
using UnityEngine;
using Utf8Json;

public class SignedToken : IJsonSerializable
{
	public readonly string token;

	public readonly string signature;

	[SerializationConstructor]
	public SignedToken(string token, string signature)
	{
		this.token = token;
		this.signature = signature;
	}

	public void Serialize(NetworkWriter writer)
	{
		writer.WriteString(token);
		writer.WriteString(signature);
	}

	public static SignedToken Deserialize(NetworkReader reader)
	{
		return new SignedToken(reader.ReadString(), reader.ReadString());
	}

	public bool TryGetToken<T>(string usage, out T token, out string error, out string userId, int expTimeOffset = 0) where T : Token, IJsonSerializable
	{
		try
		{
			token = null;
			error = null;
			userId = null;
			if (!ECDSA.Verify(this.token, signature, ServerConsole.PublicKey))
			{
				error = "invalid signature of token used for " + usage;
				return false;
			}
			T val = JsonSerialize.FromJson<T>(StringUtils.Base64Decode(this.token));
			userId = val.UserId;
			if (val.TokenVersion != 2)
			{
				error = $"invalid token version. Expected: {2}, got: {val.TokenVersion}";
				return false;
			}
			if (!val.Usage.Equals(usage, StringComparison.Ordinal))
			{
				error = "invalid token usage. Expected: " + usage + ", got: " + val.Usage;
				return false;
			}
			if (val.ExpirationTime < DateTime.UtcNow.AddMinutes(-expTimeOffset))
			{
				error = "expired token used for " + usage;
				return false;
			}
			if (val.IssuanceTime > DateTime.UtcNow.AddMinutes(20.0))
			{
				error = "non-issued token used for " + usage;
				return false;
			}
			if (val.TestSignature && !CentralServer.TestServer)
			{
				error = "test-only token used for " + usage;
				return false;
			}
			token = val;
			return true;
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog("Failed to TryGetToken<>: " + ex.Message, Color.red);
			GameCore.Console.AddLog(ex.StackTrace, Color.red);
			throw;
		}
	}
}
