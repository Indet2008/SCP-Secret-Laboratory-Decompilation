using System.Text;
using UnityEngine;

namespace GameCore
{
	public readonly struct ConsoleLog
	{
		private const int FormattedTextLengthBase = 25;

		public readonly string Text;

		public readonly Color Color;

		public readonly bool NoSpace;

		public int FormattedTextLength => 25 + Text.Length;

		public ConsoleLog(string text, Color color, bool nospace)
		{
			Text = text;
			Color = color;
			NoSpace = nospace;
		}

		public void AppendFormatted(StringBuilder sb)
		{
			sb.Append(NoSpace ? "\n" : "\n\n");
			sb.Append("<color=").Append(Color.ToHex()).Append('>');
			sb.Append(Text);
			sb.Append("</color>");
		}
	}
}
