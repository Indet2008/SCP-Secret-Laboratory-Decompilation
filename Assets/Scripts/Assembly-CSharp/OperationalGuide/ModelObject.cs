namespace OperationalGuide
{
	public class ModelObject : global::OperationalGuide.PannableObject
	{
		private global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.InventorySubcontroller _inventoryModel;

		public global::System.Action<global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.InventorySubcontroller> OnInventoryModelSet;

		public ItemType ItemHeld;

		protected global::InventorySystem.Items.ItemIdentifier ItemIdentifier;

		public global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.InventorySubcontroller InventoryModel
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		public override void Enable()
		{
		}

		private void OnInvModelSet(global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.InventorySubcontroller inventorySubcontroller)
		{
		}

		private void OnDestroy()
		{
		}

		public override void OnUpdate()
		{
		}

		public virtual void UpdateHeldItem(ItemType newItem)
		{
		}

		public ModelObject()
		{
		}
	}
}
