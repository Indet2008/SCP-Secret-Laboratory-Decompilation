using Mirror;

namespace Hints
{
	public static class ItemCategoryHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, ItemCategoryHintParameter value)
		{
			value.Serialize(writer);
		}

		public static ItemCategoryHintParameter Deserialize(this NetworkReader reader)
		{
			return ItemCategoryHintParameter.FromNetwork(reader);
		}
	}
}
