using Mirror;

namespace Hints
{
	public static class ULongHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, ULongHintParameter value)
		{
			value.Serialize(writer);
		}

		public static ULongHintParameter Deserialize(this NetworkReader reader)
		{
			return ULongHintParameter.FromNetwork(reader);
		}
	}
}
