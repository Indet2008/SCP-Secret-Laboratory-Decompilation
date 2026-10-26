using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using UnityEngine;

namespace Cassie.Interpreters
{
	public class ModifierInterpreter : CassieInterpreter
	{
		public const char ModifierHeaderSymbol = '$';

		public const char ModifierPartsSeparator = '_';

		private const string PitchPrefix = "PITCH";

		private const string VolumePrefix = "VOL";

		private const string StartTimePrefix = "STARTT";

		private const string MaxDurationPrefix = "MAXDUR";

		private const string SleepPrefix = "SLEEP";

		private const string SpacingOverridePrefix = "SPAC";

		private const string StutterPrefix = "STUTT";

		private const float MinPitch = 0.01f;

		private const float MaxPitch = 15f;

		private static readonly List<float> PartsNonAlloc = new List<float>();

		protected override NextAction ProcessWord(ReadOnlySpan<char> word, CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, StringBuilder subtitleBuilder, List<Result> lines)
		{
			if (!TryParse(word, ref modifiers))
			{
				return NextAction.Continue;
			}
			return NextAction.Halt;
		}

		private static bool TryParse(ReadOnlySpan<char> word, ref CassiePlaybackModifiers mod)
		{
			if (word.IsEmpty || word[0] != '$')
			{
				return false;
			}
			if (TryMatchPrefix("PITCH", 1, word))
			{
				mod.Pitch = Mathf.Clamp(PartsNonAlloc[0], 0.01f, 15f);
				return true;
			}
			if (TryMatchPrefix("VOL", 1, word))
			{
				mod.Volume = Mathf.Clamp01(PartsNonAlloc[0]);
				return true;
			}
			if (TryMatchPrefix("STARTT", 1, word))
			{
				mod.StartTime = Mathf.Max(0f, PartsNonAlloc[0]);
				return true;
			}
			if (TryMatchPrefix("MAXDUR", 1, word))
			{
				mod.MaxDuration = Mathf.Max(0f, PartsNonAlloc[0]);
				return true;
			}
			if (TryMatchPrefix("SLEEP", 1, word))
			{
				mod.Sleep = Mathf.Max(0f, PartsNonAlloc[0]);
				return true;
			}
			if (TryMatchPrefix("SPAC", 1, word))
			{
				mod.SpacingOverride = Mathf.Max(0f, PartsNonAlloc[0]);
				return true;
			}
			if (TryMatchPrefix("STUTT", 3, word))
			{
				mod.Stutter = new CassieStutterSettings(PartsNonAlloc[0], PartsNonAlloc[1], Mathf.RoundToInt(PartsNonAlloc[2]));
				return true;
			}
			return false;
		}

		private static bool TryMatchPrefix(string prefix, int minParts, ReadOnlySpan<char> word)
		{
			PartsNonAlloc.Clear();
			int? prevSeparator = null;
			for (int i = 1; i < word.Length; i++)
			{
				if (i <= prefix.Length && prefix[i - 1] != word[i])
				{
					return false;
				}
				if (word[i] == '_')
				{
					ProcessSeparator(prevSeparator, i, word);
					prevSeparator = i;
				}
			}
			ProcessSeparator(prevSeparator, word.Length, word);
			return PartsNonAlloc.Count >= minParts;
			static void ProcessSeparator(int? num, int curSeparator, ReadOnlySpan<char> readOnlySpan)
			{
				if (num.HasValue && float.TryParse(readOnlySpan[(num.Value + 1)..curSeparator], NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
				{
					PartsNonAlloc.Add(result);
				}
			}
		}
	}
}
