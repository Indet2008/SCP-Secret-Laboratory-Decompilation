using Mirror;

namespace Hints
{
	public static class TranslationHintFunctions
	{
		public static void Serialize(this NetworkWriter writer, TranslationHint value)
		{
			value.Serialize(writer);
		}

		public static TranslationHint Deserialize(this NetworkReader reader)
		{
			return TranslationHint.FromNetwork(reader);
		}
	}
}
