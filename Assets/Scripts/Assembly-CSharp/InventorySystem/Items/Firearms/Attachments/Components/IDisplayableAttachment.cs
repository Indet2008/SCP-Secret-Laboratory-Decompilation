using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public interface IDisplayableAttachment
	{
		Texture2D Icon { get; set; }

		Vector2 IconOffset { get; set; }

		int ParentId { get; }

		Vector2 ParentOffset { get; }
	}
}
