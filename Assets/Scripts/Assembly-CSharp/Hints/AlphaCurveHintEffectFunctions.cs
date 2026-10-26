using Mirror;

namespace Hints
{
	public static class AlphaCurveHintEffectFunctions
	{
		public static void Serialize(this NetworkWriter writer, AlphaCurveHintEffect value)
		{
			value.Serialize(writer);
		}

		public static AlphaCurveHintEffect Deserialize(this NetworkReader reader)
		{
			return AlphaCurveHintEffect.FromNetwork(reader);
		}
	}
}
