using System;
using System.Security.Cryptography;

namespace Cryptography
{
	public static class PBKDF2
	{
		public static string Pbkdf2HashString(string password, byte[] salt, int iterations, int outputBytes)
		{
			return Convert.ToBase64String(Pbkdf2HashBytes(password, salt, iterations, outputBytes));
		}

		public static byte[] Pbkdf2HashBytes(string password, byte[] salt, int iterations, int outputBytes)
		{
			using Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, salt)
			{
				IterationCount = iterations
			};
			return rfc2898DeriveBytes.GetBytes(outputBytes);
		}
	}
}
