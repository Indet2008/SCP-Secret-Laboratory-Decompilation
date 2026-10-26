using System;
using InventorySystem.Items;
using InventorySystem.Items.Firearms.Ammo;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.GUI
{
	[Serializable]
	public class AmmoElement : MonoBehaviour
	{
		[SerializeField]
		private RawImage _iconImg;

		[SerializeField]
		private TextMeshProUGUI _nameTxt;

		[SerializeField]
		private RectTransform _myTransform;

		[SerializeField]
		private float _minX;

		[SerializeField]
		private float _maxX;

		[SerializeField]
		private float _minY;

		[SerializeField]
		private float _maxY;

		[SerializeField]
		private Graphic[] _paintableParts;

		[SerializeField]
		private TextMeshProUGUI _amountIndicator;

		[SerializeField]
		private TextMeshProUGUI _lowText;

		[SerializeField]
		private TextMeshProUGUI _medText;

		[SerializeField]
		private TextMeshProUGUI _highText;

		[SerializeField]
		private CanvasGroup _dropCanvas;

		private const float DropInvalidAlpha = 0.1f;

		private int _lowAmount;

		private int _medAmount;

		private int _highAmount;

		private bool _allowDropping;

		private ItemBase _targetItem;

		public void UseButton(int type)
		{
			if (_allowDropping)
			{
				int num = type switch
				{
					1 => _medAmount, 
					0 => _lowAmount, 
					_ => _highAmount, 
				};
				ReferenceHub.LocalHub.inventory.CmdDropAmmo((byte)_targetItem.ItemTypeId, (ushort)num);
			}
		}

		public void Setup(ItemType type, Color classColor)
		{
			if (!InventoryItemLoader.AvailableItems.TryGetValue(type, out _targetItem))
			{
				throw new InvalidOperationException("Item " + type.ToString() + " is not defined. Cannot create an ammo element for it.");
			}
			_iconImg.texture = _targetItem.Icon;
			_nameTxt.text = ((_targetItem is IItemNametag itemNametag) ? itemNametag.Name : type.ToString());
			Graphic[] paintableParts = _paintableParts;
			for (int i = 0; i < paintableParts.Length; i++)
			{
				paintableParts[i].color = classColor;
			}
		}

		public void UpdateAmount(int amount)
		{
			if (amount == 0)
			{
				base.gameObject.SetActive(value: false);
				return;
			}
			base.gameObject.SetActive(value: true);
			_amountIndicator.text = amount.ToString();
			if (_targetItem is AmmoItem { PickupDropModel: AmmoPickup pickupDropModel })
			{
				_medAmount = pickupDropModel.SavedAmmo;
				_highAmount = _medAmount * 2;
				_lowAmount = (((float)_medAmount % 2f == 0f) ? (_medAmount / 2) : (_medAmount * 2 / 3));
			}
			else
			{
				_highAmount = amount;
				_medAmount = Mathf.FloorToInt((float)amount / 2f);
				_lowAmount = ((_medAmount != 1) ? 1 : 0);
			}
			if (amount < _medAmount)
			{
				if (amount > _lowAmount)
				{
					_medAmount = amount;
				}
				else
				{
					_lowAmount = amount;
					_medAmount = 0;
				}
				_highAmount = 0;
			}
			else if (amount < _highAmount)
			{
				_highAmount = ((amount != _medAmount) ? amount : 0);
			}
			PrepButton(_lowText, _lowAmount);
			PrepButton(_medText, _medAmount);
			PrepButton(_highText, _highAmount);
		}

		public bool IsHovering()
		{
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(_myTransform, Input.mousePosition, null, out var localPoint) && localPoint.x > _minX && localPoint.x < _maxX && localPoint.y > _minY)
			{
				return localPoint.y < _maxY;
			}
			return false;
		}

		private void PrepButton(TextMeshProUGUI t, int amount)
		{
			t.transform.parent.gameObject.SetActive(amount > 0);
			if (amount > 0)
			{
				t.text = amount + "x";
			}
		}

		private void Update()
		{
			_allowDropping = ReferenceHub.TryGetLocalHub(out var hub) && IAmmoDropPreventer.CanDropAmmo(hub, _targetItem.ItemTypeId);
			_dropCanvas.alpha = (_allowDropping ? 1f : 0.1f);
		}
	}
}
