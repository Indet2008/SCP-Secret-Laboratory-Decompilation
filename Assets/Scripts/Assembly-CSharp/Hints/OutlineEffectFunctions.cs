using Mirror;

namespace Hints
{
	public static class OutlineEffectFunctions
	{
		public static void Serialize(this NetworkWriter writer, OutlineEffect value)
		{
			value.Serialize(writer);
		}

		public static OutlineEffect Deserialize(this NetworkReader reader)
		{
			return OutlineEffect.FromNetwork(reader);
		}
	}
}
