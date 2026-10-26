using Mirror;

namespace Hints
{
	public static class SByteHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, SByteHintParameter value)
		{
			value.Serialize(writer);
		}

		public static SByteHintParameter Deserialize(this NetworkReader reader)
		{
			return SByteHintParameter.FromNetwork(reader);
		}
	}
}
