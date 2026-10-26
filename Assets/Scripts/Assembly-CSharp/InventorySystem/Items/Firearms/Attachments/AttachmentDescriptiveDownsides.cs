using System;

namespace InventorySystem.Items.Firearms.Attachments
{
	[Flags]
	public enum AttachmentDescriptiveDownsides
	{
		None = 0,
		Laser = 2,
		NoHeadshots = 4
	}
}
