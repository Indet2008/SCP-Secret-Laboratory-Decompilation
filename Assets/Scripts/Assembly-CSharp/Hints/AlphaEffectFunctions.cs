using Mirror;

namespace Hints
{
	public static class AlphaEffectFunctions
	{
		public static void Serialize(this NetworkWriter writer, AlphaEffect value)
		{
			value.Serialize(writer);
		}

		public static AlphaEffect Deserialize(this NetworkReader reader)
		{
			return AlphaEffect.FromNetwork(reader);
		}
	}
}
