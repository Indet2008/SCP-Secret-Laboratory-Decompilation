using InventorySystem.Items.Firearms.Attachments;

namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IEquipperModule
	{
		float DisplayBaseEquipTime { get; }

		bool IsEquipped { get; }

		float GetDisplayEffectiveEquipTime(Firearm fa)
		{
			return (DisplayBaseEquipTime + fa.AttachmentsValue(AttachmentParam.DrawTimeModifier)) / fa.AttachmentsValue(AttachmentParam.DrawSpeedMultiplier);
		}
	}
}
