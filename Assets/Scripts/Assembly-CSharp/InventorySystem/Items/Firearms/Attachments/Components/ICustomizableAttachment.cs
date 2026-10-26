using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public interface ICustomizableAttachment
	{
		AttachmentConfigWindow ConfigWindow { get; }

		Vector2 ConfigIconOffset { get; }

		float ConfigIconScale { get; }
	}
}
