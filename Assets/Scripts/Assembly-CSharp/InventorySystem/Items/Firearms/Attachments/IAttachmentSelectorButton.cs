using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	public interface IAttachmentSelectorButton
	{
		RectTransform RectTransform { get; }

		byte ButtonId { get; set; }

		void Setup(Texture icon, AttachmentSlot slot, Vector2? pos, Firearm fa);
	}
}
