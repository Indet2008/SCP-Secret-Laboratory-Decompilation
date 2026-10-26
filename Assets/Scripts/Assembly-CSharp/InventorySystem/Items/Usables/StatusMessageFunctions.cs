using Mirror;

namespace InventorySystem.Items.Usables
{
	public static class StatusMessageFunctions
	{
		public static void Serialize(this NetworkWriter writer, StatusMessage value)
		{
			value.Serialize(writer);
		}

		public static StatusMessage Deserialize(this NetworkReader reader)
		{
			return new StatusMessage((StatusMessage.StatusType)reader.ReadByte(), reader.ReadUShort());
		}
	}
}
