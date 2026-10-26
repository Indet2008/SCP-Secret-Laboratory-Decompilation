using Mirror;

namespace Hints
{
	public static class PackedULongHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, PackedULongHintParameter value)
		{
			value.Serialize(writer);
		}

		public static PackedULongHintParameter Deserialize(this NetworkReader reader)
		{
			return PackedULongHintParameter.FromNetwork(reader);
		}
	}
}
