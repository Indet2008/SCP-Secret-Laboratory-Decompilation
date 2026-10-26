using System;
using Cryptography;
using Mirror;

namespace CentralAuth
{
	public static class AuthenticationResponseFunctions
	{
		[Flags]
		private enum AuthenticationResponseFlags : byte
		{
			AuthToken = 1,
			BadgeToken = 2,
			DoNotTrack = 4,
			HideBadge = 8
		}

		public static void SerializeAuthenticationResponse(this NetworkWriter writer, AuthenticationResponse value)
		{
			AuthenticationResponseFlags authenticationResponseFlags = (AuthenticationResponseFlags)0;
			if (value.SignedAuthToken != null)
			{
				authenticationResponseFlags |= AuthenticationResponseFlags.AuthToken;
			}
			if (value.SignedBadgeToken != null)
			{
				authenticationResponseFlags |= AuthenticationResponseFlags.BadgeToken;
			}
			if (value.DoNotTrack)
			{
				authenticationResponseFlags |= AuthenticationResponseFlags.DoNotTrack;
			}
			if (value.HideBadge)
			{
				authenticationResponseFlags |= AuthenticationResponseFlags.HideBadge;
			}
			writer.WriteByte((byte)authenticationResponseFlags);
			value.SignedAuthToken?.Serialize(writer);
			value.SignedBadgeToken?.Serialize(writer);
			writer.WriteString(ECDSA.KeyToString(value.PublicKey));
			writer.WriteString(value.EcdhPublicKey);
			writer.WriteArray(value.EcdhPublicKeySignature);
		}

		public static AuthenticationResponse DeserializeAuthenticationResponse(this NetworkReader reader)
		{
			AuthenticationResponseFlags flags = (AuthenticationResponseFlags)reader.ReadByte();
			return new AuthenticationResponse(flags.HasFlagFast(AuthenticationResponseFlags.AuthToken) ? SignedToken.Deserialize(reader) : null, flags.HasFlagFast(AuthenticationResponseFlags.BadgeToken) ? SignedToken.Deserialize(reader) : null, reader.ReadString(), reader.ReadString(), reader.ReadArray<byte>(), flags.HasFlagFast(AuthenticationResponseFlags.DoNotTrack), flags.HasFlagFast(AuthenticationResponseFlags.HideBadge));
		}

		private static bool HasFlagFast(this AuthenticationResponseFlags flags, AuthenticationResponseFlags flag)
		{
			return (flags & flag) == flag;
		}
	}
}
