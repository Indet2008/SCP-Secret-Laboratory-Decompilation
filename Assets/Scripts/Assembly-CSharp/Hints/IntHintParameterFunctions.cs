using Mirror;

namespace Hints
{
	public static class IntHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, IntHintParameter value)
		{
			value.Serialize(writer);
		}

		public static IntHintParameter Deserialize(this NetworkReader reader)
		{
			return IntHintParameter.FromNetwork(reader);
		}
	}
}
