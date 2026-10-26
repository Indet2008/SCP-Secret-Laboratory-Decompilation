using Mirror;

namespace InventorySystem.Items.Firearms.Attachments
{
	public struct AttachmentsSetupPreference : NetworkMessage
	{
		public ItemType Weapon;

		public uint AttachmentsCode;

		public AttachmentsSetupPreference(NetworkReader reader)
		{
			Weapon = (ItemType)reader.ReadByte();
			AttachmentsCode = reader.ReadUInt();
		}

		public readonly void Serialize(NetworkWriter writer)
		{
			writer.WriteByte((byte)Weapon);
			writer.WriteUInt(AttachmentsCode);
		}
	}
}
