using System;
using System.Security.Cryptography;
using System.Text;
using GameCore;
using NorthwoodLib.Pools;

public static class RandomGenerator
{
	private static readonly Random Random;

	private static readonly bool CryptoRng;

	private static readonly byte[] OneByte;

	private static readonly byte[] TwoBytes;

	private static readonly byte[] FourBytes;

	private static readonly byte[] EightBytes;

	private static readonly byte[] SixteenBytes;

	private const string Alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	static RandomGenerator()
	{
		Random = new Random();
		OneByte = new byte[1];
		TwoBytes = new byte[2];
		FourBytes = new byte[4];
		EightBytes = new byte[8];
		SixteenBytes = new byte[16];
		CryptoRng = ConfigFile.ServerConfig.GetBool("use_crypto_rng");
	}

	public static bool GetBool(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetBoolUnsecure();
		}
		return GetBoolSecure();
	}

	private static bool GetBoolSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(OneByte);
		return OneByte[0] > 127;
	}

	private static bool GetBoolUnsecure()
	{
		Random.NextBytes(OneByte);
		return OneByte[0] > 127;
	}

	public static string GetStringSecure(int length)
	{
		if (length <= 0)
		{
			throw new ArgumentException("Length must be greater than 0.", "length");
		}
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(length);
		try
		{
			for (int i = 0; i < length; i++)
			{
				stringBuilder.Append("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"[RandomNumberGenerator.GetInt32(0, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".Length)]);
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
		catch
		{
			StringBuilderPool.Shared.Return(stringBuilder);
			throw;
		}
	}

	public static byte[] GetBytes(int count, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetBytesUnsecure(count);
		}
		return GetBytesSecure(count);
	}

	private static byte[] GetBytesSecure(int count)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		byte[] array = new byte[count];
		rNGCryptoServiceProvider.GetBytes(array);
		return array;
	}

	private static byte[] GetBytesUnsecure(int count)
	{
		byte[] array = new byte[count];
		Random.NextBytes(array);
		return array;
	}

	public static byte GetByte(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetByteUnsecure();
		}
		return GetByteSecure();
	}

	private static byte GetByteSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(OneByte);
		return OneByte[0];
	}

	private static byte GetByteUnsecure()
	{
		Random.NextBytes(OneByte);
		return OneByte[0];
	}

	public static sbyte GetSByte(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetSByteUnsecure();
		}
		return GetSByteSecure();
	}

	private static sbyte GetSByteSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(OneByte);
		return (sbyte)OneByte[0];
	}

	private static sbyte GetSByteUnsecure()
	{
		Random.NextBytes(OneByte);
		return (sbyte)OneByte[0];
	}

	public static short GetInt16(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt16Unsecure();
		}
		return GetInt16Secure();
	}

	private static short GetInt16Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(TwoBytes);
		return BitConverter.ToInt16(TwoBytes, 0);
	}

	private static short GetInt16Unsecure()
	{
		Random.NextBytes(TwoBytes);
		return BitConverter.ToInt16(TwoBytes, 0);
	}

	public static ushort GetUInt16(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt16Unsecure();
		}
		return GetUInt16Secure();
	}

	private static ushort GetUInt16Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(TwoBytes);
		return BitConverter.ToUInt16(TwoBytes, 0);
	}

	private static ushort GetUInt16Unsecure()
	{
		Random.NextBytes(TwoBytes);
		return BitConverter.ToUInt16(TwoBytes, 0);
	}

	public static int GetInt32(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt32Unsecure();
		}
		return GetInt32Secure();
	}

	private static int GetInt32Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		return BitConverter.ToInt32(FourBytes, 0);
	}

	private static int GetInt32Unsecure()
	{
		Random.NextBytes(FourBytes);
		return BitConverter.ToInt32(FourBytes, 0);
	}

	public static uint GetUInt32(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt32Unsecure();
		}
		return GetUInt32Secure();
	}

	private static uint GetUInt32Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		return BitConverter.ToUInt32(FourBytes, 0);
	}

	private static uint GetUInt32Unsecure()
	{
		Random.NextBytes(FourBytes);
		return BitConverter.ToUInt32(FourBytes, 0);
	}

	public static long GetInt64(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt64Unsecure();
		}
		return GetInt64Secure();
	}

	private static long GetInt64Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		return BitConverter.ToInt64(EightBytes, 0);
	}

	private static long GetInt64Unsecure()
	{
		Random.NextBytes(EightBytes);
		return BitConverter.ToInt64(EightBytes, 0);
	}

	public static ulong GetUInt64(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt64Unsecure();
		}
		return GetUInt64Secure();
	}

	private static ulong GetUInt64Secure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		return BitConverter.ToUInt64(EightBytes, 0);
	}

	private static ulong GetUInt64Unsecure()
	{
		Random.NextBytes(EightBytes);
		return BitConverter.ToUInt64(EightBytes, 0);
	}

	public static float GetFloat(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetFloatUnsecure();
		}
		return GetFloatSecure();
	}

	private static float GetFloatSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		return BitConverter.ToSingle(FourBytes, 0);
	}

	private static float GetFloatUnsecure()
	{
		Random.NextBytes(FourBytes);
		return BitConverter.ToSingle(FourBytes, 0);
	}

	public static double GetDouble(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetDoubleUnsecure();
		}
		return GetDoubleSecure();
	}

	private static double GetDoubleSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		return BitConverter.ToDouble(EightBytes, 0);
	}

	private static double GetDoubleUnsecure()
	{
		Random.NextBytes(EightBytes);
		return BitConverter.ToDouble(EightBytes, 0);
	}

	public static decimal GetDecimal(bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetDecimalUnsecure();
		}
		return GetDecimalSecure();
	}

	private static decimal GetDecimalSecure()
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(SixteenBytes);
		return new decimal(new int[4]
		{
			BitConverter.ToInt32(SixteenBytes, 0),
			BitConverter.ToInt32(SixteenBytes, 4),
			BitConverter.ToInt32(SixteenBytes, 8),
			BitConverter.ToInt32(SixteenBytes, 12)
		});
	}

	private static decimal GetDecimalUnsecure()
	{
		Random.NextBytes(SixteenBytes);
		return new decimal(new int[4]
		{
			BitConverter.ToInt32(SixteenBytes, 0),
			BitConverter.ToInt32(SixteenBytes, 4),
			BitConverter.ToInt32(SixteenBytes, 8),
			BitConverter.ToInt32(SixteenBytes, 12)
		});
	}

	public static byte GetByte(byte min, byte max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetByteUnsecure(min, max);
		}
		return GetByteSecure(min, max);
	}

	private static byte GetByteSecure(byte min, byte max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(OneByte);
		byte b = OneByte[0];
		while (b < min || b >= max)
		{
			rNGCryptoServiceProvider.GetBytes(OneByte);
			b = OneByte[0];
		}
		return b;
	}

	private static byte GetByteUnsecure(byte min, byte max)
	{
		Random.NextBytes(OneByte);
		byte b = OneByte[0];
		while (b < min || b >= max)
		{
			Random.NextBytes(OneByte);
			b = OneByte[0];
		}
		return b;
	}

	public static sbyte GetSByte(sbyte min, sbyte max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetSByteUnsecure(min, max);
		}
		return GetSByteSecure(min, max);
	}

	private static sbyte GetSByteSecure(sbyte min, sbyte max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(OneByte);
		sbyte b = (sbyte)OneByte[0];
		while (b < min || b >= max)
		{
			rNGCryptoServiceProvider.GetBytes(OneByte);
			b = (sbyte)OneByte[0];
		}
		return b;
	}

	private static sbyte GetSByteUnsecure(sbyte min, sbyte max)
	{
		Random.NextBytes(OneByte);
		sbyte b = (sbyte)OneByte[0];
		while (b < min || b >= max)
		{
			Random.NextBytes(OneByte);
			b = (sbyte)OneByte[0];
		}
		return b;
	}

	public static short GetInt16(short min, short max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt16Unsecure(min, max);
		}
		return GetInt16Secure(min, max);
	}

	private static short GetInt16Secure(short min, short max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(TwoBytes);
		short num = BitConverter.ToInt16(TwoBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(TwoBytes);
			num = BitConverter.ToInt16(TwoBytes, 0);
		}
		return num;
	}

	private static short GetInt16Unsecure(short min, short max)
	{
		Random.NextBytes(TwoBytes);
		short num = BitConverter.ToInt16(TwoBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(TwoBytes);
			num = BitConverter.ToInt16(TwoBytes, 0);
		}
		return num;
	}

	public static ushort GetUInt16(ushort min, ushort max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt16Unsecure(min, max);
		}
		return GetUInt16Secure(min, max);
	}

	private static ushort GetUInt16Secure(ushort min, ushort max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(TwoBytes);
		ushort num = BitConverter.ToUInt16(TwoBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(TwoBytes);
			num = BitConverter.ToUInt16(TwoBytes, 0);
		}
		return num;
	}

	private static ushort GetUInt16Unsecure(ushort min, ushort max)
	{
		Random.NextBytes(TwoBytes);
		ushort num = BitConverter.ToUInt16(TwoBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(TwoBytes);
			num = BitConverter.ToUInt16(TwoBytes, 0);
		}
		return num;
	}

	public static int GetInt32(int min, int max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt32Unsecure(min, max);
		}
		return GetInt32Secure(min, max);
	}

	private static int GetInt32Secure(int min, int max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		int num = BitConverter.ToInt32(FourBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(FourBytes);
			num = BitConverter.ToInt32(FourBytes, 0);
		}
		return num;
	}

	private static int GetInt32Unsecure(int min, int max)
	{
		Random.NextBytes(FourBytes);
		int num = BitConverter.ToInt32(FourBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(FourBytes);
			num = BitConverter.ToInt32(FourBytes, 0);
		}
		return num;
	}

	public static uint GetUInt32(uint min, uint max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt32Unsecure(min, max);
		}
		return GetUInt32Secure(min, max);
	}

	private static uint GetUInt32Secure(uint min, uint max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		uint num = BitConverter.ToUInt32(FourBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(FourBytes);
			num = BitConverter.ToUInt32(FourBytes, 0);
		}
		return num;
	}

	private static uint GetUInt32Unsecure(uint min, uint max)
	{
		Random.NextBytes(FourBytes);
		uint num = BitConverter.ToUInt32(FourBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(FourBytes);
			num = BitConverter.ToUInt32(FourBytes, 0);
		}
		return num;
	}

	public static long GetInt64(long min, long max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetInt64Unsecure(min, max);
		}
		return GetInt64Secure(min, max);
	}

	private static long GetInt64Secure(long min, long max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		long num = BitConverter.ToInt64(EightBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(EightBytes);
			num = BitConverter.ToInt64(EightBytes, 0);
		}
		return num;
	}

	private static long GetInt64Unsecure(long min, long max)
	{
		Random.NextBytes(EightBytes);
		long num = BitConverter.ToInt64(EightBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(EightBytes);
			num = BitConverter.ToInt64(EightBytes, 0);
		}
		return num;
	}

	public static ulong GetUInt64(ulong min, ulong max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetUInt64Unsecure(min, max);
		}
		return GetUInt64Secure(min, max);
	}

	private static ulong GetUInt64Secure(ulong min, ulong max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		ulong num = BitConverter.ToUInt64(EightBytes, 0);
		while (num < min || num >= max)
		{
			rNGCryptoServiceProvider.GetBytes(EightBytes);
			num = BitConverter.ToUInt64(EightBytes, 0);
		}
		return num;
	}

	private static ulong GetUInt64Unsecure(ulong min, ulong max)
	{
		Random.NextBytes(EightBytes);
		ulong num = BitConverter.ToUInt64(EightBytes, 0);
		while (num < min || num >= max)
		{
			Random.NextBytes(EightBytes);
			num = BitConverter.ToUInt64(EightBytes, 0);
		}
		return num;
	}

	public static float GetFloat(float min, float max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetFloatUnsecure(min, max);
		}
		return GetFloatSecure(min, max);
	}

	private static float GetFloatSecure(float min, float max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(FourBytes);
		float num = BitConverter.ToSingle(FourBytes, 0);
		while (num < min || num > max)
		{
			rNGCryptoServiceProvider.GetBytes(FourBytes);
			num = BitConverter.ToSingle(FourBytes, 0);
		}
		return num;
	}

	private static float GetFloatUnsecure(float min, float max)
	{
		Random.NextBytes(FourBytes);
		float num = BitConverter.ToSingle(FourBytes, 0);
		while (num < min || num > max)
		{
			Random.NextBytes(FourBytes);
			num = BitConverter.ToSingle(FourBytes, 0);
		}
		return num;
	}

	public static double GetDouble(double min, double max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetDoubleUnsecure(min, max);
		}
		return GetDoubleSecure(min, max);
	}

	private static double GetDoubleSecure(double min, double max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(EightBytes);
		double num = BitConverter.ToDouble(EightBytes, 0);
		while (num < min || num > max)
		{
			rNGCryptoServiceProvider.GetBytes(EightBytes);
			num = BitConverter.ToDouble(EightBytes, 0);
		}
		return num;
	}

	private static double GetDoubleUnsecure(double min, double max)
	{
		Random.NextBytes(EightBytes);
		double num = BitConverter.ToDouble(EightBytes, 0);
		while (num < min || num > max)
		{
			Random.NextBytes(EightBytes);
			num = BitConverter.ToDouble(EightBytes, 0);
		}
		return num;
	}

	public static decimal GetDecimal(decimal min, decimal max, bool secure = false)
	{
		if (!secure && !CryptoRng)
		{
			return GetDecimalUnsecure(min, max);
		}
		return GetDecimalSecure(min, max);
	}

	private static decimal GetDecimalSecure(decimal min, decimal max)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		rNGCryptoServiceProvider.GetBytes(SixteenBytes);
		decimal num = new decimal(new int[4]
		{
			BitConverter.ToInt32(SixteenBytes, 0),
			BitConverter.ToInt32(SixteenBytes, 4),
			BitConverter.ToInt32(SixteenBytes, 8),
			BitConverter.ToInt32(SixteenBytes, 12)
		});
		while (num < min || num > max)
		{
			rNGCryptoServiceProvider.GetBytes(SixteenBytes);
			num = new decimal(new int[4]
			{
				BitConverter.ToInt32(SixteenBytes, 0),
				BitConverter.ToInt32(SixteenBytes, 4),
				BitConverter.ToInt32(SixteenBytes, 8),
				BitConverter.ToInt32(SixteenBytes, 12)
			});
		}
		return num;
	}

	private static decimal GetDecimalUnsecure(decimal min, decimal max)
	{
		Random.NextBytes(SixteenBytes);
		decimal num = new decimal(new int[4]
		{
			BitConverter.ToInt32(SixteenBytes, 0),
			BitConverter.ToInt32(SixteenBytes, 4),
			BitConverter.ToInt32(SixteenBytes, 8),
			BitConverter.ToInt32(SixteenBytes, 12)
		});
		while (num < min || num > max)
		{
			Random.NextBytes(SixteenBytes);
			num = new decimal(new int[4]
			{
				BitConverter.ToInt32(SixteenBytes, 0),
				BitConverter.ToInt32(SixteenBytes, 4),
				BitConverter.ToInt32(SixteenBytes, 8),
				BitConverter.ToInt32(SixteenBytes, 12)
			});
		}
		return num;
	}
}
