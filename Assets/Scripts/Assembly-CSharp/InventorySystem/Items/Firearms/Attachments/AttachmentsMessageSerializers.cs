using Mirror;

namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentsMessageSerializers
	{
		public static void WriteAttachmentsChangeRequest(this NetworkWriter writer, AttachmentsChangeRequest value)
		{
			value.Serialize(writer);
		}

		public static AttachmentsChangeRequest ReadAttachmentsChangeRequest(this NetworkReader reader)
		{
			return new AttachmentsChangeRequest(reader);
		}

		public static void WriteAttachmentsSetupPreference(this NetworkWriter writer, AttachmentsSetupPreference value)
		{
			value.Serialize(writer);
		}

		public static AttachmentsSetupPreference ReadAttachmentsSetupPreference(this NetworkReader reader)
		{
			return new AttachmentsSetupPreference(reader);
		}
	}
}
