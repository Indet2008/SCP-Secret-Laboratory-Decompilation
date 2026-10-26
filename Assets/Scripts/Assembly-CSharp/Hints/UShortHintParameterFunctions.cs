using Mirror;

namespace Hints
{
	public static class UShortHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, UShortHintParameter value)
		{
			value.Serialize(writer);
		}

		public static UShortHintParameter Deserialize(this NetworkReader reader)
		{
			return UShortHintParameter.FromNetwork(reader);
		}
	}
}
