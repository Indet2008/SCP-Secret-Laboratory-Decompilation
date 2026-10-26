using System;
using System.Collections.Generic;
using Utf8Json;

namespace Authenticator
{
	public readonly struct AuthenticatorPlayerObjects : IEquatable<AuthenticatorPlayerObjects>, IJsonSerializable
	{
		public readonly List<AuthenticatorPlayerObject> objects;

		[SerializationConstructor]
		public AuthenticatorPlayerObjects(List<AuthenticatorPlayerObject> objects)
		{
			this.objects = objects;
		}

		public bool Equals(AuthenticatorPlayerObjects other)
		{
			return objects == other.objects;
		}

		public override bool Equals(object obj)
		{
			if (obj is AuthenticatorPlayerObjects other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			if (objects == null)
			{
				return 0;
			}
			return objects.GetHashCode();
		}

		public static bool operator ==(AuthenticatorPlayerObjects left, AuthenticatorPlayerObjects right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(AuthenticatorPlayerObjects left, AuthenticatorPlayerObjects right)
		{
			return !left.Equals(right);
		}
	}
}
