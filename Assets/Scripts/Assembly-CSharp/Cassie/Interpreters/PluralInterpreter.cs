using System;

namespace Cassie.Interpreters
{
	public class PluralInterpreter : SuffixInterpreterBase
	{
		private const string SuffixRegular = "_suffix_plural_regular";

		private const string SuffixSyllabic = "_suffix_plural_syllabic";

		protected override bool TryFindLemma(ReadOnlySpan<char> word, CassieLineDatabase db, out CassieLine originalLine)
		{
			ReadOnlySpan<char> readOnlySpan;
			if (word.EndsWith("ies"))
			{
				readOnlySpan = word;
				string text = readOnlySpan.Slice(0, readOnlySpan.Length - 3).ToString() + "y";
				if (db.TryGetLine(text.AsSpan(), out originalLine))
				{
					return true;
				}
			}
			if (word.EndsWith("es".AsSpan()))
			{
				readOnlySpan = word;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 2), out originalLine))
				{
					return true;
				}
			}
			if (word.EndsWith("s".AsSpan()))
			{
				readOnlySpan = word;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 1), out originalLine))
				{
					return true;
				}
			}
			originalLine = null;
			return false;
		}

		protected override string GetSuffix(ReadOnlySpan<char> word, CassieLine originalLine, out float spaceOffset, out float cutoffTime)
		{
			spaceOffset = 0f;
			cutoffTime = 0f;
			string apiName = originalLine.ApiName;
			char c = apiName[apiName.Length - 1];
			if (c != 's' && c != 'x' && c != 'z' && !apiName.EndsWith("ss") && !apiName.EndsWith("sh") && !apiName.EndsWith("ch") && !apiName.EndsWith("ge") && !apiName.EndsWith("ce") && !apiName.EndsWith("dge"))
			{
				return "_suffix_plural_regular";
			}
			return "_suffix_plural_syllabic";
		}
	}
}
