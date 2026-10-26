using Mirror;

namespace Hints
{
	public static class ItemHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, ItemHintParameter value)
		{
			value.Serialize(writer);
		}

		public static ItemHintParameter Deserialize(this NetworkReader reader)
		{
			return ItemHintParameter.FromNetwork(reader);
		}
	}
}
