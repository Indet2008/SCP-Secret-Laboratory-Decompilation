using System;
using System.Buffers.Binary;

namespace Query
{
	public readonly struct QueryHandshake
	{
		[Flags]
		public enum ClientFlags : byte
		{
			None = 0,
			SuppressRaResponses = 1,
			SubscribeServerConsole = 2,
			SubscribeServerLogs = 4,
			RemoteAdminMetadata = 8,
			RestrictPermissions = 0x10,
			SpecifyLogUsername = 0x20
		}

		public readonly ushort MaxPacketSize;

		public readonly long Timestamp;

		public readonly byte[] AuthChallenge;

		public readonly ushort ServerTimeoutThreshold;

		public readonly ClientFlags Flags;

		public readonly ulong Permissions;

		public readonly byte KickPower;

		public readonly string Username;

		public const int ChallengeLength = 24;

		private const int CommonSize = 34;

		public const int SizeToClient = 36;

		public int SizeToServer
		{
			get
			{
				int num = (Flags.HasFlagFast(ClientFlags.RestrictPermissions) ? 9 : 0);
				int num2 = (Flags.HasFlagFast(ClientFlags.SpecifyLogUsername) ? Utf8.GetLength(Username) : 0);
				return 35 + num + num2;
			}
		}

		public QueryHandshake(ushort maxPacketSize, long timestamp, byte[] authChallenge, ClientFlags flags = ClientFlags.None, ulong permissions = ulong.MaxValue, byte kickPower = byte.MaxValue, string username = null, ushort serverTimeoutThreshold = 0)
		{
			if (authChallenge.Length != 24)
			{
				throw new ArgumentException($"Auth challenge must be {24} bytes long.", "authChallenge");
			}
			if (flags.HasFlagFast(ClientFlags.SpecifyLogUsername) && string.IsNullOrWhiteSpace(username))
			{
				throw new ArgumentException("Username must be specified (and not be empty or whitespace) when ClientFlags.SpecifyLogUsername is set.", "username");
			}
			MaxPacketSize = maxPacketSize;
			Timestamp = timestamp;
			AuthChallenge = authChallenge;
			ServerTimeoutThreshold = serverTimeoutThreshold;
			Flags = flags;
			Permissions = permissions;
			KickPower = kickPower;
			Username = username;
		}

		public QueryHandshake(ushort maxPacketSize, byte[] authChallenge, ClientFlags flags = ClientFlags.None, ulong permissions = ulong.MaxValue, byte kickPower = byte.MaxValue, string username = null, ushort serverTimeoutThreshold = 0)
			: this(maxPacketSize, DateTimeOffset.UtcNow.ToUnixTimeSeconds(), authChallenge, flags, permissions, kickPower, username, serverTimeoutThreshold)
		{
		}

		public bool Validate(int timeTolerance = 120)
		{
			return Math.Abs(DateTimeOffset.UtcNow.ToUnixTimeSeconds() - Timestamp) <= timeTolerance;
		}

		public int Serialize(Span<byte> buffer, bool toServer)
		{
			BinaryPrimitives.WriteUInt16BigEndian(buffer.Slice(0, 2), MaxPacketSize);
			BinaryPrimitives.WriteInt64BigEndian(buffer.Slice(2, 8), Timestamp);
			AuthChallenge.CopyTo(buffer.Slice(10, 24));
			BinaryPrimitives.WriteUInt16BigEndian(buffer.Slice(34, 2), ServerTimeoutThreshold);
			return 36;
		}

		public static QueryHandshake Deserialize(ReadOnlySpan<byte> buffer, bool toServer)
		{
			ushort maxPacketSize = BinaryPrimitives.ReadUInt16BigEndian(buffer.Slice(0, 2));
			long timestamp = BinaryPrimitives.ReadInt64BigEndian(buffer.Slice(2, 8));
			byte[] authChallenge = buffer.Slice(10, 24).ToArray();
			ClientFlags clientFlags = (ClientFlags)buffer[34];
			ulong permissions = ulong.MaxValue;
			byte kickPower = byte.MaxValue;
			string username = null;
			int num = 35;
			if (clientFlags.HasFlagFast(ClientFlags.RestrictPermissions))
			{
				permissions = BinaryPrimitives.ReadUInt64BigEndian(buffer.Slice(num, 8));
				num += 8;
				kickPower = buffer[num++];
			}
			if (clientFlags.HasFlagFast(ClientFlags.SpecifyLogUsername))
			{
				username = Utf8.GetString(buffer, num, buffer.Length - num);
			}
			return new QueryHandshake(maxPacketSize, timestamp, authChallenge, clientFlags, permissions, kickPower, username, 0);
		}
	}
}
