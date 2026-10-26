using System;
using Utf8Json;

public struct GlobalBanningResponse : IEquatable<GlobalBanningResponse>, IJsonSerializable
{
	public readonly bool Success;

	public readonly string Message;

	[SerializationConstructor]
	public GlobalBanningResponse(bool success, string message)
	{
		Success = success;
		Message = message;
	}

	public bool Equals(GlobalBanningResponse other)
	{
		if (Success == other.Success)
		{
			return Message == other.Message;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is GlobalBanningResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(Success, Message);
	}
}
