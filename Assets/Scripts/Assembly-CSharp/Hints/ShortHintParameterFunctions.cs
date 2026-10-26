using Mirror;

namespace Hints
{
	public static class ShortHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, ShortHintParameter value)
		{
			value.Serialize(writer);
		}

		public static ShortHintParameter Deserialize(this NetworkReader reader)
		{
			return ShortHintParameter.FromNetwork(reader);
		}
	}
}
