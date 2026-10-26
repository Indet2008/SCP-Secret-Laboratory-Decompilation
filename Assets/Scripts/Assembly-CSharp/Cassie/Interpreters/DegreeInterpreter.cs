using System;

namespace Cassie.Interpreters
{
	public class DegreeInterpreter : SuffixInterpreterBase
	{
		private const string SuffixComparative = "_SUFFIX_ER";

		private const string SuffixSuperlative = "_SUFFIX_EST";

		protected override bool TryFindLemma(ReadOnlySpan<char> word, CassieLineDatabase db, out CassieLine originalLine)
		{
			if (word.Length <= 3)
			{
				originalLine = null;
				return false;
			}
			if (TryFindLemmaForDegree(word, db, "ER", "IER", out originalLine))
			{
				return true;
			}
			if (TryFindLemmaForDegree(word, db, "EST", "IEST", out originalLine))
			{
				return true;
			}
			originalLine = null;
			return false;
		}

		private static bool TryFindLemmaForDegree(ReadOnlySpan<char> word, CassieLineDatabase db, string suffix, string ySuffix, out CassieLine originalLine)
		{
			if (!word.EndsWith(suffix))
			{
				originalLine = null;
				return false;
			}
			ReadOnlySpan<char> readOnlySpan;
			int length;
			if (word.EndsWith(ySuffix) && word.Length > ySuffix.Length)
			{
				readOnlySpan = word;
				length = ySuffix.Length;
				string text = readOnlySpan.Slice(0, readOnlySpan.Length - length).ToString() + "Y";
				if (db.TryGetLine(text.AsSpan(), out originalLine))
				{
					return true;
				}
			}
			readOnlySpan = word;
			length = suffix.Length;
			ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(0, readOnlySpan.Length - length);
			if (readOnlySpan2.Length >= 2)
			{
				if (readOnlySpan2[readOnlySpan2.Length - 1] == readOnlySpan2[readOnlySpan2.Length - 2])
				{
					readOnlySpan = readOnlySpan2;
					if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 1), out originalLine))
					{
						return true;
					}
				}
			}
			int num = suffix.Length - 1;
			if (word.Length > num)
			{
				readOnlySpan = word;
				length = num;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - length), out originalLine))
				{
					return true;
				}
			}
			if (db.TryGetLine(readOnlySpan2, out originalLine))
			{
				return true;
			}
			originalLine = null;
			return false;
		}

		protected override string GetSuffix(ReadOnlySpan<char> word, CassieLine originalLine, out float spaceOffset, out float cutoffTime)
		{
			spaceOffset = -0.08f;
			cutoffTime = 0.06f;
			if (!word.EndsWith("EST"))
			{
				return "_SUFFIX_ER";
			}
			return "_SUFFIX_EST";
		}
	}
}
