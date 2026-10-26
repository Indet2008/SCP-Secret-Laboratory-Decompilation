using Mirror;

namespace Hints
{
	public class TranslationHint : FormattableHint<TranslationHint>
	{
		public const string TranslationFile = "GameHints";

		protected HintTranslations Translation { get; private set; }

		public static TranslationHint FromNetwork(NetworkReader reader)
		{
			TranslationHint translationHint = new TranslationHint();
			translationHint.Deserialize(reader);
			return translationHint;
		}

		private TranslationHint()
			: base((HintParameter[])null, (HintEffect[])null, 0f)
		{
		}

		public TranslationHint(HintTranslations translation, HintParameter[] parameters = null, HintEffect[] effects = null, float durationScalar = 3f)
			: base(parameters, effects, durationScalar)
		{
			Translation = translation;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Translation = (HintTranslations)reader.ReadByte();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteByte((byte)Translation);
		}
	}
}
