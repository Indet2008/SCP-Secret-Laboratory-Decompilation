using InventorySystem.Items;
using TMPro;
using UnityEngine;

namespace InventorySystem.GUI.Descriptions
{
	public class EmptyDescriptionGui : RadialDescriptionBase
	{
		[SerializeField]
		private TextMeshProUGUI _desc;

		public override void UpdateInfo(ItemBase targetItem, Color roleColor)
		{
			_desc.text = ((targetItem is IItemNametag itemNametag) ? itemNametag.Name : targetItem.ItemTypeId.ToString());
		}
	}
}
