using Mirror;

namespace InventorySystem.Items.Firearms.Attachments
{
	public struct AttachmentsChangeRequest : NetworkMessage
	{
		public ushort WeaponSerial;

		public uint AttachmentsCode;

		public AttachmentsChangeRequest(NetworkReader reader)
		{
			WeaponSerial = reader.ReadUShort();
			AttachmentsCode = reader.ReadUInt();
		}

		public readonly void Serialize(NetworkWriter writer)
		{
			writer.WriteUShort(WeaponSerial);
			writer.WriteUInt(AttachmentsCode);
		}
	}
}
