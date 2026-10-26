using System;

namespace InventorySystem.Items.Firearms.Attachments
{
	[Flags]
	public enum AttachmentParamState
	{
		Disabled = 0,
		UserInterface = 2,
		SilentlyActive = 4,
		ActiveAndDisplayed = UserInterface | SilentlyActive
	}
}
