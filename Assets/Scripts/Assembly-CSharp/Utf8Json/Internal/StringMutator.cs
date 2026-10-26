using System.Text;

namespace Utf8Json.Internal
{
	internal static class StringMutator
	{
		public static string Original(string s)
		{
			return s;
		}

		public static string ToCamelCase(string s)
		{
			if (string.IsNullOrEmpty(s) || char.IsLower(s, 0))
			{
				return s;
			}
			char[] array = s.ToCharArray();
			array[0] = char.ToLowerInvariant(array[0]);
			return new string(array);
		}

		public static string ToSnakeCase(string s)
		{
			if (string.IsNullOrEmpty(s))
			{
				return s;
			}
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < s.Length; i++)
			{
				char c = s[i];
				if (char.IsUpper(c))
				{
					if (i == 0)
					{
						stringBuilder.Append(char.ToLowerInvariant(c));
						continue;
					}
					if (char.IsUpper(s[i - 1]))
					{
						stringBuilder.Append(char.ToLowerInvariant(c));
						continue;
					}
					stringBuilder.Append("_");
					stringBuilder.Append(char.ToLowerInvariant(c));
				}
				else
				{
					stringBuilder.Append(c);
				}
			}
			return stringBuilder.ToString();
		}
	}
}
