using Mirror;

namespace Hints
{
	public static class PackedLongHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, PackedLongHintParameter value)
		{
			value.Serialize(writer);
		}

		public static PackedLongHintParameter Deserialize(this NetworkReader reader)
		{
			return PackedLongHintParameter.FromNetwork(reader);
		}
	}
}
