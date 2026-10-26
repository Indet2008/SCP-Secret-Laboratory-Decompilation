using System;
using System.Buffers.Binary;

public readonly struct RemoteAdminResponse : IEquatable<RemoteAdminResponse>
{
	[Flags]
	public enum RemoteAdminResponseFlags : byte
	{
		Successful = 1,
		LogInConsole = 2
	}

	public readonly string Content;

	public readonly RemoteAdminResponseFlags Flags;

	public readonly string OverrideDisplay;

	private const int HeaderSize = 5;

	public int GetLength => ((Content != null) ? Utf8.GetLength(Content) : 0) + ((OverrideDisplay != null) ? Utf8.GetLength(OverrideDisplay) : 0) + 5;

	public RemoteAdminResponse(string content, RemoteAdminResponseFlags flags, string overrideDisplay)
	{
		Content = (string.IsNullOrEmpty(content) ? null : content);
		Flags = flags;
		OverrideDisplay = (string.IsNullOrEmpty(overrideDisplay) ? null : overrideDisplay);
	}

	public RemoteAdminResponse(string content, bool isSuccess, bool logInConsole, string overrideDisplay)
		: this(content, (RemoteAdminResponseFlags)((isSuccess ? 1 : 0) | (logInConsole ? 2 : 0)), overrideDisplay)
	{
	}

	public byte[] Serialize()
	{
		byte[] array = new byte[GetLength];
		Serialize(array);
		return array;
	}

	public void Serialize(byte[] array)
	{
		array[0] = (byte)Flags;
		int num = ((Content != null) ? Utf8.GetBytes(Content, array, 5) : 0);
		BinaryPrimitives.WriteInt32BigEndian(new Span<byte>(array, 1, 4), num);
		if (OverrideDisplay != null)
		{
			Utf8.GetBytes(OverrideDisplay, array, num + 5);
		}
	}

	public static RemoteAdminResponse Deserialize(byte[] array, int length)
	{
		int num = BinaryPrimitives.ReadInt32BigEndian(new Span<byte>(array, 1, 4));
		return new RemoteAdminResponse((num > 0) ? Utf8.GetString(array, 5, num) : null, overrideDisplay: (num + 5 < length) ? Utf8.GetString(array, num + 5, length - num - 5) : null, flags: (RemoteAdminResponseFlags)array[0]);
	}

	public bool Equals(RemoteAdminResponse other)
	{
		if (string.Equals(Content, other.Content) && Flags == other.Flags)
		{
			return string.Equals(OverrideDisplay, other.OverrideDisplay);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is RemoteAdminResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((((Content != null) ? Content.GetHashCode() : 0) * 397) ^ Flags.GetHashCode()) * 397) ^ ((OverrideDisplay != null) ? OverrideDisplay.GetHashCode() : 0);
	}

	public static bool operator ==(RemoteAdminResponse left, RemoteAdminResponse right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(RemoteAdminResponse left, RemoteAdminResponse right)
	{
		return !left.Equals(right);
	}

	public bool HasFlag(RemoteAdminResponseFlags flag)
	{
		return (Flags & flag) == flag;
	}
}
