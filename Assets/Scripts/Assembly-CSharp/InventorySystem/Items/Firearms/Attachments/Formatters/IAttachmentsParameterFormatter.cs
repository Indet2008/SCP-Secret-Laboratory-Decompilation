namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public interface IAttachmentsParameterFormatter
	{
		float DefaultValue { get; }

		bool FormatParameter(AttachmentParam param, Firearm firearm, int attachmentId, float newValue, out string formattedText, out bool isGood);
	}
}
