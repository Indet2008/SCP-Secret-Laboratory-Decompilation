using System;
using System.Collections.Generic;
using System.Text;

namespace Cassie.Interpreters
{
	public class LookupWordInterpreter : CassieInterpreter
	{
		protected override NextAction ProcessWord(ReadOnlySpan<char> word, CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, StringBuilder subtitleBuilder, List<Result> lines)
		{
			bool flag = false;
			if (!database.TryGetLine(word, out var line))
			{
				if (word.IsEmpty)
				{
					return NextAction.Continue;
				}
				char c = word[word.Length - 1];
				if (c != '.' && c != ',')
				{
					return NextAction.Continue;
				}
				ReadOnlySpan<char> readOnlySpan = word;
				if (!database.TryGetLine(readOnlySpan.Slice(0, readOnlySpan.Length - 1), out line))
				{
					return NextAction.Continue;
				}
				flag = true;
			}
			lines.Add(new Result(line, modifiers));
			modifiers.ResetSingleUseModifiers();
			if (flag && database.TryGetLine(".".AsSpan(), out var line2))
			{
				lines.Add(new Result(line2, modifiers));
			}
			if (subtitleBuilder != null && line.Type == CassieClipCategory.Word)
			{
				subtitleBuilder.Append(word);
				subtitleBuilder.Append(' ');
			}
			return NextAction.Halt;
		}
	}
}
