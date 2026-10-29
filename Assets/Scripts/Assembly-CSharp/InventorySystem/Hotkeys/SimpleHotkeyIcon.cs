using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys
{
	public class SimpleHotkeyIcon : HotkeyIconBase
	{
		[SerializeField]
		private RawImage _icon;

		[SerializeField]
		private HotkeyApperance _size;

		public override bool CheckCompatibility(ItemBase item, HotkeyApperance apperance)
		{
			return apperance == _size;
		}

		public override void SetItem(ItemBase item)
		{
			_icon.texture = item.Icon;
		}
	}
}
