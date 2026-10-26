using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items;
using InventorySystem.Items.Keycards;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.GUI.Descriptions
{
	public class KeycardDescriptionGui : RadialDescriptionBase
	{
		[SerializeField]
		private TextMeshProUGUI _title;

		[SerializeField]
		private Graphic[] _containmentIcons;

		[SerializeField]
		private Graphic[] _armoryIcons;

		[SerializeField]
		private Graphic[] _adminIcons;

		[SerializeField]
		private Graphic[] _otherColorable;

		public override void UpdateInfo(ItemBase targetItem, Color roleColor)
		{
			KeycardItem keycardItem = targetItem as KeycardItem;
			KeycardLevels keycardLevels = new KeycardLevels(keycardItem.GetPermissions(null));
			SetLevel(_containmentIcons, keycardLevels.Containment, roleColor);
			SetLevel(_armoryIcons, keycardLevels.Armory, roleColor);
			SetLevel(_adminIcons, keycardLevels.Admin, roleColor);
			Graphic[] otherColorable = _otherColorable;
			for (int i = 0; i < otherColorable.Length; i++)
			{
				otherColorable[i].color = roleColor;
			}
			_title.text = keycardItem.Name;
		}

		private void SetLevel(Graphic[] arr, int level, Color roleColor)
		{
			for (int i = 0; i < arr.Length; i++)
			{
				Graphic obj = arr[i];
				obj.color = roleColor;
				obj.enabled = i < level;
			}
		}
	}
}
