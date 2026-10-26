using Mirror;

namespace Hints
{
	public static class LongHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, LongHintParameter value)
		{
			value.Serialize(writer);
		}

		public static LongHintParameter Deserialize(this NetworkReader reader)
		{
			return LongHintParameter.FromNetwork(reader);
		}
	}
}
