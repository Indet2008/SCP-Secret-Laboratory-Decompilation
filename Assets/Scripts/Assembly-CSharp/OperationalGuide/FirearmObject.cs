using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Thirdperson;
using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;

namespace OperationalGuide
{
	public class FirearmObject : ModelObject
	{
		public override void UpdateHeldItem(ItemType newItem)
		{
			ItemIdentifier = new ItemIdentifier(newItem, 0);
			ItemHeld = newItem;
			base.InventoryModel.UpdateHeldItem(ItemIdentifier, instant: true);
		}

		public override void Enable()
		{
			base.Enable();
			InventorySubcontroller.OnSwapThirdpersonItem += OnThirdPersonItemChange;
		}

		public override void Disable()
		{
			InventorySubcontroller.OnSwapThirdpersonItem -= OnThirdPersonItemChange;
		}

		// Shows the player's saved attachment preset on the displayed weapon.
		private void OnThirdPersonItemChange(ThirdpersonItemBase newInstance)
		{
			if (newInstance is FirearmThirdpersonItem firearmThirdpersonItem && firearmThirdpersonItem.WorldmodelInstance.WorldmodelType == FirearmWorldmodelType.Presentation)
			{
				firearmThirdpersonItem.WorldmodelInstance.Setup(ItemIdentifier, FirearmWorldmodelType.Presentation, AttachmentPreferences.GetSavedPreferenceCode(ItemHeld));
			}
		}
	}
}
