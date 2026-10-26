using System;

namespace Cassie.Interpreters
{
	public class ContinuousInterpreter : SuffixInterpreterBase
	{
		protected override bool TryFindLemma(ReadOnlySpan<char> word, CassieLineDatabase db, out CassieLine originalLine)
		{
			if (word.Length <= 3 || !word.EndsWith("ING".AsSpan()))
			{
				originalLine = null;
				return false;
			}
			ReadOnlySpan<char> readOnlySpan = word;
			ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(0, readOnlySpan.Length - 3);
			if (db.TryGetLine(readOnlySpan2, out originalLine))
			{
				return true;
			}
			if (readOnlySpan2[readOnlySpan2.Length - 1] == readOnlySpan2[readOnlySpan2.Length - 2])
			{
				readOnlySpan = readOnlySpan2;
				if (db.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 1), out originalLine))
				{
					return true;
				}
			}
			ReadOnlySpan<char> word2 = (readOnlySpan2.ToString() + "E").AsSpan();
			if (db.TryGetLine(word2, out originalLine))
			{
				return true;
			}
			originalLine = null;
			return false;
		}

		protected override string GetSuffix(ReadOnlySpan<char> word, CassieLine originalLine, out float spaceOffset, out float cutoffTime)
		{
			spaceOffset = -0.08f;
			cutoffTime = 0.08f;
			return "_SUFFIX_ING";
		}
	}
}
