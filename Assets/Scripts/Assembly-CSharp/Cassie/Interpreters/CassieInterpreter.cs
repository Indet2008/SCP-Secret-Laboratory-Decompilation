using System;
using System.Collections.Generic;
using System.Text;

namespace Cassie.Interpreters
{
	public abstract class CassieInterpreter
	{
		protected enum NextAction
		{
			Continue = 0,
			Halt = 1
		}

		public readonly struct Result
		{
			public readonly CassieLine Line;

			public readonly CassiePlaybackModifiers Modifiers;

			public Result(CassieLine line, CassiePlaybackModifiers modifiers)
			{
				Line = line;
				Modifiers = modifiers;
			}
		}

		private static readonly List<Result> ResultNonAlloc = new List<Result>();

		public List<Result> GetResults(CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, ReadOnlySpan<char> word, StringBuilder subtitleBuilder, out bool halt)
		{
			ResultNonAlloc.Clear();
			NextAction nextAction = ProcessWord(word, database, ref modifiers, subtitleBuilder, ResultNonAlloc);
			halt = nextAction == NextAction.Halt;
			return ResultNonAlloc;
		}

		protected abstract NextAction ProcessWord(ReadOnlySpan<char> word, CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, StringBuilder subtitleBuilder, List<Result> lines);
	}
}
