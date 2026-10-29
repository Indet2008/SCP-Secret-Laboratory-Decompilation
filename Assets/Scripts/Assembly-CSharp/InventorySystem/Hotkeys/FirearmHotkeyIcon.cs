using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys
{
	public class FirearmHotkeyIcon : HotkeyIconBase
	{
		[SerializeField]
		private RawImage _rootIcon;

		[SerializeField]
		private RawImage[] _attachmentsPool;

		[SerializeField]
		private RectTransform _transformToFit;

		[SerializeField]
		private float _horizontalPadding;

		[SerializeField]
		private Vector2 _maxSize;

		private uint _prevAttachments;

		private ushort _prevSerial;

		private bool _refresh;

		public override bool CheckCompatibility(ItemBase item, HotkeyApperance apperance)
		{
			if (item is Firearm)
			{
				return apperance == HotkeyApperance.NormalIcon;
			}
			return false;
		}

		public override void SetItem(ItemBase item)
		{
			if (item is Firearm firearm && (_refresh || firearm.GetCurrentAttachmentsCode() != _prevAttachments || _prevSerial != firearm.ItemSerial))
			{
				UpdateIcon(firearm);
			}
		}

		public override void SetColors(Color color)
		{
			base.SetColors(color);
			_refresh = true;
		}

		private void UpdateIcon(Firearm firearm)
		{
			Vector2 vector = firearm.GenerateIcon(_rootIcon, _attachmentsPool, _maxSize, (int x) => Outline.color);
			_rootIcon.color = Outline.color;
			_transformToFit.sizeDelta = new Vector2(vector.x + _horizontalPadding, _transformToFit.sizeDelta.y);
			_prevSerial = firearm.ItemSerial;
			_prevAttachments = firearm.GetCurrentAttachmentsCode();
		}
	}
}
