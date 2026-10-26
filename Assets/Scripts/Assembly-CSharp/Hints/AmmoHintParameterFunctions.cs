using Mirror;

namespace Hints
{
	public static class AmmoHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, AmmoHintParameter value)
		{
			value.Serialize(writer);
		}

		public static AmmoHintParameter Deserialize(this NetworkReader reader)
		{
			return AmmoHintParameter.FromNetwork(reader);
		}
	}
}
