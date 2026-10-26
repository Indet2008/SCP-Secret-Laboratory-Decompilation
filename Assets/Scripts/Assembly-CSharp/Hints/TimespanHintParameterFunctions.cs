using Mirror;

namespace Hints
{
	public static class TimespanHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, TimespanHintParameter value)
		{
			value.Serialize(writer);
		}

		public static TimespanHintParameter Deserialize(this NetworkReader reader)
		{
			return TimespanHintParameter.FromNetwork(reader);
		}
	}
}
