using Mirror;

namespace Hints
{
	public static class StringHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, StringHintParameter value)
		{
			value.Serialize(writer);
		}

		public static StringHintParameter Deserialize(this NetworkReader reader)
		{
			return StringHintParameter.FromNetwork(reader);
		}
	}
}
