using System;
using InventorySystem.Items;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;

namespace OperationalGuide
{
	public class ModelObject : PannableObject
	{
		private InventorySubcontroller _inventoryModel;

		public Action<InventorySubcontroller> OnInventoryModelSet;

		public ItemType ItemHeld = ItemType.None;

		protected ItemIdentifier ItemIdentifier = new ItemIdentifier(ItemType.None, 0);

		public InventorySubcontroller InventoryModel
		{
			get
			{
				return _inventoryModel;
			}
			set
			{
				_inventoryModel = value;
				OnInventoryModelSet?.Invoke(_inventoryModel);
			}
		}

		public override void Enable()
		{
			YAxisModifer = 0f;
			OnInventoryModelSet = (Action<InventorySubcontroller>)Delegate.Combine(OnInventoryModelSet, new Action<InventorySubcontroller>(OnInvModelSet));
		}

		private void OnInvModelSet(InventorySubcontroller inventorySubcontroller)
		{
			inventorySubcontroller.Model.Animator.keepAnimatorStateOnDisable = true;
		}

		private void OnDestroy()
		{
			OnInventoryModelSet = (Action<InventorySubcontroller>)Delegate.Remove(OnInventoryModelSet, new Action<InventorySubcontroller>(OnInvModelSet));
		}

		public override void OnUpdate()
		{
			_inventoryModel.UpdateHeldItem(ItemIdentifier, instant: true);
		}

		public virtual void UpdateHeldItem(ItemType newItem)
		{
			ItemHeld = newItem;
			ItemIdentifier = new ItemIdentifier(newItem, 0);
		}
	}
}
