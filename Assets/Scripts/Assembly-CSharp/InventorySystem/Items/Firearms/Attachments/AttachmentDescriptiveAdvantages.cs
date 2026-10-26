using System;

namespace InventorySystem.Items.Firearms.Attachments
{
	[Flags]
	public enum AttachmentDescriptiveAdvantages
	{
		None = 0,
		Flashlight = 2,
		AmmoCounter = 4,
		FlashSuppression = 8,
		NightVision = 0x10,
		ShotgunShells = 0x20
	}
}
