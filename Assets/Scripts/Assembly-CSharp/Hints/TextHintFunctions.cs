using Mirror;

namespace Hints
{
	public static class TextHintFunctions
	{
		public static void Serialize(this NetworkWriter writer, TextHint value)
		{
			value.Serialize(writer);
		}

		public static TextHint Deserialize(this NetworkReader reader)
		{
			return TextHint.FromNetwork(reader);
		}
	}
}
