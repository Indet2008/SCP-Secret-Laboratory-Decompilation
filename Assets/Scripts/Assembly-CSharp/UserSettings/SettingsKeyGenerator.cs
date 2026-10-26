using System;
using System.Collections.Generic;
using System.Text;

namespace UserSettings
{
	public static class SettingsKeyGenerator
	{
		private static readonly Dictionary<Type, ushort> TypeToHash = new Dictionary<Type, ushort>();

		private static readonly Dictionary<ushort, Type> HashToType = new Dictionary<ushort, Type>();

		private static readonly char[] HexNonAlloc32 = new char[4];

		private static readonly char[] IntToHexArr = new char[16]
		{
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
			'A', 'B', 'C', 'D', 'E', 'F'
		};

		private static readonly StringBuilder KeyBuilder = new StringBuilder("UserSettings_FFFF_FFFF");

		private const int HexLength = 4;

		private const int SbHashStartIndex = 13;

		private const int SbValueStartIndex = 18;

		public static string EnumToKey<T>(T val) where T : Enum, IConvertible
		{
			return TypeValueToKey(GetStableTypeHash(typeof(T)), val.ToUInt16(null));
		}

		public static string TypeValueToKey(ushort typeHash, ushort value)
		{
			UshortToHex(typeHash);
			for (int i = 0; i < 4; i++)
			{
				KeyBuilder[13 + i] = HexNonAlloc32[i];
			}
			UshortToHex(value);
			for (int j = 0; j < 4; j++)
			{
				KeyBuilder[18 + j] = HexNonAlloc32[j];
			}
			return KeyBuilder.ToString();
		}

		public static ushort GetStableTypeHash(Type type, bool preventCaching = false)
		{
			if (!preventCaching && TypeToHash.TryGetValue(type, out var value))
			{
				return value;
			}
			if (!type.IsEnum)
			{
				throw new ArgumentException("To reduce hash collisions, this method can only be used with enums!", "type");
			}
			int num = 23;
			string name = type.Name;
			foreach (char c in name)
			{
				num = num * 31 + c;
			}
			ushort num2 = (ushort)(num & 0xFFFF);
			if (preventCaching)
			{
				return num2;
			}
			if (HashToType.TryGetValue(num2, out var value2))
			{
				throw new InvalidOperationException("Type " + type.Name + " hash-collided with type " + value2.Name + ". Consider renaming one of the enums.");
			}
			HashToType[num2] = type;
			TypeToHash[type] = num2;
			return num2;
		}

		private static void UshortToHex(ushort val)
		{
			int num = 0;
			for (int i = 0; i < 4; i++)
			{
				HexNonAlloc32[i] = IntToHexArr[(val >> num) & 0xF];
				num += 4;
			}
		}
	}
}
