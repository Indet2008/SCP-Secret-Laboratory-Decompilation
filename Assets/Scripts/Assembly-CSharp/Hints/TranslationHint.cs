using System;
using Mirror;

namespace Hints
{
	public class TranslationHint : FormattableHint<TranslationHint>
	{
		public const string TranslationFile = "GameHints";

		protected override Func<TranslationHint, float, string> FormattedTextStrategy
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

		protected HintTranslations Translation { get; private set; }

		private static string FormattedTextStrategy0(TranslationHint self, float progress)
		{
			return TranslationReader.GetFormatted("GameHints", (int)self.Translation, "NO_TRANSLATION", Array.Empty<object>());
		}

		private static string FormattedTextStrategy1(TranslationHint self, float progress)
		{
			return TranslationReader.GetFormatted("GameHints", (int)self.Translation, "NO_TRANSLATION", self.Parameters[0].Formatted);
		}

		private static string FormattedTextStrategy2(TranslationHint self, float progress)
		{
			return TranslationReader.GetFormatted("GameHints", (int)self.Translation, "NO_TRANSLATION", self.Parameters[0].Formatted, self.Parameters[1].Formatted);
		}

		private static string FormattedTextStrategy3(TranslationHint self, float progress)
		{
			return TranslationReader.GetFormatted("GameHints", (int)self.Translation, "NO_TRANSLATION", self.Parameters[0].Formatted, self.Parameters[1].Formatted, self.Parameters[2].Formatted);
		}

		private static string FormattedTextStrategyOther(TranslationHint self, float progress)
		{
			object[] array = new object[self.Parameters.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = self.Parameters[i].Formatted;
			}
			return string.Format(TranslationReader.Get("GameHints", (int)self.Translation, "NO_TRANSLATION"), array);
		}

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
