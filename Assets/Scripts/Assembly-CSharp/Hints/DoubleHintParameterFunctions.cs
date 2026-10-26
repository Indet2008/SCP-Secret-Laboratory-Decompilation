using Mirror;

namespace Hints
{
	public static class DoubleHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, DoubleHintParameter value)
		{
			value.Serialize(writer);
		}

		public static DoubleHintParameter Deserialize(this NetworkReader reader)
		{
			return DoubleHintParameter.FromNetwork(reader);
		}
	}
}
