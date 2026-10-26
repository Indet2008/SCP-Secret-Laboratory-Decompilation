using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace Cassie.Interpreters
{
	public abstract class SuffixInterpreterBase : CassieInterpreter
	{
		protected override NextAction ProcessWord(ReadOnlySpan<char> word, CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, StringBuilder subtitleBuilder, List<Result> lines)
		{
			if (!TryFindLemma(word, database, out var originalLine))
			{
				return NextAction.Continue;
			}
			string suffix = GetSuffix(word, originalLine, out var spaceOffset, out var cutoffOffset);
			if (!database.TryGetLine(suffix, out var line))
			{
				Debug.LogError("Unable to find suffix: " + suffix);
				return NextAction.Continue;
			}
			float? spacingOverride = modifiers.SpacingOverride;
			float? maxDuration = modifiers.MaxDuration;
			double num = modifiers.GetTimeUntilNextWord(originalLine) + (double)spaceOffset;
			double num2 = num + (double)cutoffOffset;
			modifiers.SpacingOverride = (float)num;
			modifiers.MaxDuration = (float)num2;
			lines.Add(new Result(originalLine, modifiers));
			modifiers.SpacingOverride = spacingOverride;
			modifiers.MaxDuration = maxDuration;
			lines.Add(new Result(line, modifiers));
			subtitleBuilder?.Append(word);
			subtitleBuilder?.Append(' ');
			modifiers.ResetSingleUseModifiers();
			return NextAction.Halt;
		}

		protected abstract bool TryFindLemma(ReadOnlySpan<char> word, CassieLineDatabase db, out CassieLine originalLine);

		protected abstract string GetSuffix(ReadOnlySpan<char> promptedWord, CassieLine originalLine, out float spaceOffset, out float cutoffOffset);
	}
}
