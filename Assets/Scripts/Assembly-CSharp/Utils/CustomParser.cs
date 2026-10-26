using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using UnityEngine;

namespace Utils
{
	public static class CustomParser
	{
		public enum ParseResult : byte
		{
			FullSuccess = 0,
			PartialSuccess = 1,
			Failed = 2
		}

		private static readonly HashSet<char> KnownCharacters = new HashSet<char>("0123456789.,");

		public static bool RemoveUnknownCharacters(string source, out string res)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(source.Length);
			bool flag = false;
			foreach (char c in source)
			{
				if (KnownCharacters.Contains(c))
				{
					stringBuilder.Append(c);
				}
				else
				{
					flag = true;
				}
			}
			if (flag)
			{
				res = stringBuilder.ToString();
			}
			else
			{
				res = source;
			}
			StringBuilderPool.Shared.Return(stringBuilder);
			return flag;
		}

		public static ParseResult TryParseFloat(string source, out float val)
		{
			ParseResult result = ParseResult.FullSuccess;
			val = 0f;
			if (RemoveUnknownCharacters(source, out source))
			{
				result = ParseResult.PartialSuccess;
			}
			if (string.IsNullOrEmpty(source))
			{
				return ParseResult.Failed;
			}
			source = source.Replace(",", ".");
			if (source.Contains("."))
			{
				string[] array = source.Split('.');
				if (array.Length > 2)
				{
					string text = string.Empty;
					for (int i = 0; i < array.Length - 1; i++)
					{
						text += array[i];
					}
					array[0] = text;
					array[1] = array[^1];
				}
				if (string.IsNullOrEmpty(array[0]))
				{
					array[0] = "0";
				}
				val = float.Parse(array[0]);
				if (!string.IsNullOrEmpty(array[1]))
				{
					if (float.TryParse(array[1], out var result2))
					{
						val += result2 / Mathf.Pow(10f, array[1].Length);
					}
					else
					{
						result = ParseResult.PartialSuccess;
					}
				}
				return result;
			}
			if (!float.TryParse(source, out val))
			{
				return ParseResult.Failed;
			}
			return result;
		}

		public static ParseResult TryParseInt(string source, out int val)
		{
			ParseResult parseResult = TryParseFloat(source, out var val2);
			if (parseResult == ParseResult.Failed)
			{
				val = 0;
				return parseResult;
			}
			val = (int)val2;
			if (val2 == (float)(int)val2)
			{
				return parseResult;
			}
			return ParseResult.PartialSuccess;
		}
	}
}
