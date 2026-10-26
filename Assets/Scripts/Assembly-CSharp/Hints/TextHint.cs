using Mirror;

namespace Hints
{
	public class TextHint : FormattableHint<TextHint>
	{
		protected string Text { get; private set; }

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
