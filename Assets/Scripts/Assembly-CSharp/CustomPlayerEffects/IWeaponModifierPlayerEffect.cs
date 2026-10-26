using InventorySystem.Items.Firearms.Attachments;

namespace CustomPlayerEffects
{
	public interface IWeaponModifierPlayerEffect
	{
		bool ParamsActive { get; }

		bool TryGetWeaponParam(AttachmentParam param, out float val);
	}
}
