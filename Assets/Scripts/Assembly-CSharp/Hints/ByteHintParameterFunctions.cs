using Mirror;

namespace Hints
{
	public static class ByteHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, ByteHintParameter value)
		{
			value.Serialize(writer);
		}

		public static ByteHintParameter Deserialize(this NetworkReader reader)
		{
			return ByteHintParameter.FromNetwork(reader);
		}
	}
}
