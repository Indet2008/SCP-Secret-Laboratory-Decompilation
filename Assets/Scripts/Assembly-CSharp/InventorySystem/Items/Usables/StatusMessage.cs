using Mirror;

namespace InventorySystem.Items.Usables
{
	public struct StatusMessage : NetworkMessage
	{
		public enum StatusType : byte
		{
			Start = 0,
			Cancel = 1
		}

		public StatusType Status;

		public ushort ItemSerial;

		public StatusMessage(StatusType status, ushort serial)
		{
			Status = status;
			ItemSerial = serial;
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte((byte)Status);
			writer.WriteUShort(ItemSerial);
		}
	}
}
