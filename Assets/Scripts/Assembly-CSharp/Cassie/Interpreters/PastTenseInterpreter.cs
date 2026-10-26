using System;

namespace Cassie.Interpreters
{
	public class PastTenseInterpreter : SuffixInterpreterBase
	{
		private const string SuffixT = "_SUFFIX_PAST_T";

		private const string SuffixD = "_SUFFIX_PAST_D";

		private const string SuffixId = "_SUFFIX_PAST_ID";

		protected override bool TryFindLemma(ReadOnlySpan<char> word, CassieLineDatabase db, out CassieLine originalLine)
		{
			ReadOnlySpan<char> readOnlySpan;
			if (word.EndsWith("ED".AsSpan()))
			{
				readOnlySpan = word;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 2), out originalLine))
				{
					return true;
				}
				if (word.Length > 3)
				{
					readOnlySpan = word;
					if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 3), out originalLine))
					{
						return true;
					}
				}
			}
			if (word.EndsWith("D".AsSpan()))
			{
				readOnlySpan = word;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 1), out originalLine))
				{
					return true;
				}
			}
			if (word.EndsWith("IED".AsSpan()))
			{
				readOnlySpan = word;
				string text = readOnlySpan.Slice(0, readOnlySpan.Length - 3).ToString() + "Y";
				if (db.TryGetLine(text.AsSpan(), out originalLine))
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
			if (apiName.EndsWith('T') || apiName.EndsWith('D'))
			{
				spaceOffset = -0.065f;
				cutoffTime = 0.075f;
				return "_SUFFIX_PAST_ID";
			}
			if (apiName.EndsWith("SH") || apiName.EndsWith("CH") || apiName.EndsWith("SS"))
			{
				return "_SUFFIX_PAST_T";
			}
			char c = apiName[apiName.Length - 1];
			if (c != 'P' && c != 'K' && c != 'F' && c != 'S' && c != 'X')
			{
				return "_SUFFIX_PAST_D";
			}
			return "_SUFFIX_PAST_T";
		}
	}
}
