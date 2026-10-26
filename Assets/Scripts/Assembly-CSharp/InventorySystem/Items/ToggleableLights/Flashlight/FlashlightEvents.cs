using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Flashlight
{
	public class FlashlightEvents : MonoBehaviour
	{
		[SerializeField]
		private ItemViewmodelBase _ivb;

		private void Toggle()
		{
			if (!(_ivb.ParentItem == null) && _ivb.ParentItem.OwnerInventory.CurInstance is FlashlightItem flashlightItem)
			{
				flashlightItem.ClientSendRequest(!flashlightItem.IsEmittingLight);
			}
		}
	}
}
