using Mirror;

namespace InventorySystem.Items.Usables
{
	public static class ItemCooldownMessageFunctions
	{
		public static void Serialize(this NetworkWriter writer, ItemCooldownMessage value)
		{
			value.Serialize(writer);
		}

		public static ItemCooldownMessage Deserialize(this NetworkReader reader)
		{
			return new ItemCooldownMessage(reader.ReadUShort(), reader.ReadFloat());
		}
	}
}
