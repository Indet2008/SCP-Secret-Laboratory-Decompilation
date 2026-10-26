using Mirror;

namespace InventorySystem.Searching
{
	public static class SearchSessionFunctions
	{
		public static void Serialize(this NetworkWriter writer, SearchSession value)
		{
			value.Serialize(writer);
		}

		public static SearchSession Deserialize(this NetworkReader reader)
		{
			SearchSession result = default;
			result.Deserialize(reader);
			return result;
		}
	}
}
