using System;
using Mirror;

namespace Hints
{
	public class TextHint : FormattableHint<TextHint>
	{
		protected override Func<TextHint, float, string> FormattedTextStrategy
		{
			get
			{
				switch ((base.Parameters != null) ? base.Parameters.Length : 0)
				{
				case 0:
					return FormattedTextStrategy0;
				case 1:
					return FormattedTextStrategy1;
				case 2:
					return FormattedTextStrategy2;
				case 3:
					return FormattedTextStrategy3;
				default:
					return FormattedTextStrategyOther;
				}
			}
		}

		protected string Text { get; private set; }

		private static string FormattedTextStrategy0(TextHint self, float progress)
		{
			return self.Text;
		}

		private static string FormattedTextStrategy1(TextHint self, float progress)
		{
			return string.Format(self.Text, self.Parameters[0].Formatted);
		}

		private static string FormattedTextStrategy2(TextHint self, float progress)
		{
			return string.Format(self.Text, self.Parameters[0].Formatted, self.Parameters[1].Formatted);
		}

		private static string FormattedTextStrategy3(TextHint self, float progress)
		{
			return string.Format(self.Text, self.Parameters[0].Formatted, self.Parameters[1].Formatted, self.Parameters[2].Formatted);
		}

		private static string FormattedTextStrategyOther(TextHint self, float progress)
		{
			object[] array = new object[self.Parameters.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = self.Parameters[i].Formatted;
			}
			return string.Format(self.Text, array);
		}

		public static TextHint FromNetwork(NetworkReader reader)
		{
			TextHint textHint = new TextHint();
			textHint.Deserialize(reader);
			return textHint;
		}

		private TextHint()
			: base((HintParameter[])null, (HintEffect[])null, 0f)
		{
		}

		public TextHint(string text, HintParameter[] parameters = null, HintEffect[] effects = null, float durationScalar = 3f)
			: base(parameters, effects, durationScalar)
		{
			Text = text;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Text = reader.ReadString();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteString(Text);
		}
	}
}
