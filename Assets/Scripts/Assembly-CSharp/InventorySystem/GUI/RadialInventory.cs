using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using InventorySystem.GUI.Descriptions;
using InventorySystem.Items;
using PlayerRoles;
using RadialMenus;
using UnityEngine;
using UnityEngine.UI;
using UserSettings;
using UserSettings.ControlsSettings;

namespace InventorySystem.GUI
{
	public class RadialInventory : RadialMenuBase, IInventoryGuiDisplayType
	{
		[Serializable]
		public struct ItemSlot
		{
			[SerializeField]
			private RawImage _iconSlot;

			public void UpdateVisuals(ItemBase item)
			{
				if (item == null)
				{
					_iconSlot.enabled = false;
					return;
				}
				_iconSlot.enabled = true;
				_iconSlot.texture = item.Icon;
			}
		}

		private static readonly CachedUserSetting<bool> RightClickToDrop = new CachedUserSetting<bool>(MiscControlsSetting.RightClickToDrop);

		[SerializeField]
		private ItemSlot[] _slots;

		[SerializeField]
		private RadialDescriptionBase[] _descriptionTypes;

		[SerializeField]
		private CanvasGroup _descriptionGroup;

		[SerializeField]
		private RawImage _dragCursorIcon;

		[SerializeField]
		private Image _cursorDropIcon;

		[SerializeField]
		private AmmoElement _ammoElementTemplate;

		[SerializeField]
		private RoleAccentColor _circleColor;

		[SerializeField]
		private RoleAccentColor _highlightColor;

		[SerializeField]
		private RoleAccentColor _heldColor;

		[SerializeField]
		private RoleAccentColor _blockedColor;

		[SerializeField]
		private RoleAccentColor _wornColor;

		public readonly ushort[] OrganizedContent = new ushort[8];

		private static readonly Stopwatch DragWatch = new Stopwatch();

		private readonly Dictionary<ItemType, AmmoElement> _organizedAmmo = new Dictionary<ItemType, AmmoElement>();

		private int _draggedId;

		private ushort _highlightedSerial;

		private ushort _visibleDescriptionSerial;

		private const byte DescriptionFadeSpeed = 15;

		private const byte TransitionSpeed = 15;

		private Vector2 _originalDragPosition;

		private RoleTypeId _prevRole;

		public override int Slots => _slots.Length;

		private static bool AllowDropping => DragWatch.Elapsed.TotalMilliseconds > 90.0;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(MiscControlsSetting.RightClickToDrop, defaultValue: true);
		}

		public void InventoryToggled(bool newState)
		{
			_originalDragPosition = Vector3.zero;
			if (newState)
			{
				_descriptionGroup.alpha = 0f;
				return;
			}
			_draggedId = -1;
			_dragCursorIcon.enabled = false;
			_cursorDropIcon.enabled = false;
		}

		public InventoryGuiAction DisplayAndSelectItems(Inventory targetInventory, out ushort itemSerial)
		{
			bool flag = targetInventory == null;
			RingImage.color = _circleColor.Color;
			try
			{
				RefreshItemColors(targetInventory, flag);
				RefreshDescriptions(targetInventory, flag);
			}
			catch (Exception exception)
			{
				UnityEngine.Debug.Log("Error occured at the system inventory: " + ((targetInventory == null) ? "null" : targetInventory.isLocalPlayer.ToString()));
				UnityEngine.Debug.LogException(exception);
			}
			itemSerial = _highlightedSerial;
			if (Input.GetKeyDown(KeyCode.Mouse0))
			{
				_draggedId = base.HighlightedSlot;
				if (_draggedId >= 0 && !flag && targetInventory.UserInventory.Items.TryGetValue(OrganizedContent[_draggedId], out var value))
				{
					_originalDragPosition = Input.mousePosition;
					_dragCursorIcon.texture = value.Icon;
					_dragCursorIcon.transform.position = Input.mousePosition;
					_cursorDropIcon.color = RingImage.color;
				}
				else
				{
					_originalDragPosition = Vector2.zero;
				}
			}
			if (Input.GetKeyUp(KeyCode.Mouse0))
			{
				_dragCursorIcon.enabled = false;
				_cursorDropIcon.enabled = false;
				_originalDragPosition = Vector3.zero;
				if (_draggedId >= 0 && OrganizedContent[_draggedId] != 0 && base.HighlightedSlot < 0 && AllowDropping)
				{
					itemSerial = OrganizedContent[_draggedId];
					return InventoryGuiAction.Drop;
				}
				if (base.HighlightedSlot == _draggedId || Mathf.Min(base.HighlightedSlot, _draggedId) < 0 || OrganizedContent[_draggedId] == 0)
				{
					if (_organizedAmmo.Any((KeyValuePair<ItemType, AmmoElement> x) => x.Value.IsHovering()))
					{
						return InventoryGuiAction.None;
					}
					InventoryGuiController.InventoryVisible = false;
					return InventoryGuiAction.Select;
				}
				ushort num = OrganizedContent[base.HighlightedSlot];
				OrganizedContent[base.HighlightedSlot] = OrganizedContent[_draggedId];
				OrganizedContent[_draggedId] = num;
			}
			if (_dragCursorIcon.enabled)
			{
				_dragCursorIcon.transform.position = Input.mousePosition;
				_cursorDropIcon.enabled = !InRingRange(out var _) && AllowDropping;
			}
			else if (_draggedId >= 0 && _originalDragPosition != Vector2.zero && Vector2.Distance(_originalDragPosition, Input.mousePosition) > 5f && OrganizedContent[_draggedId] > 0)
			{
				DragWatch.Restart();
				_dragCursorIcon.enabled = true;
				_cursorDropIcon.enabled = false;
			}
			if (RightClickToDrop.Value && Input.GetKeyDown(KeyCode.Mouse1))
			{
				return InventoryGuiAction.Drop;
			}
			return InventoryGuiAction.None;
		}

		private void RefreshDescriptions(Inventory inv, bool invNull)
		{
			if (invNull)
			{
				return;
			}
			if (_visibleDescriptionSerial != _highlightedSerial || !inv.UserInventory.Items.TryGetValue(_highlightedSerial, out var value))
			{
				if (_descriptionGroup.alpha > 0f)
				{
					_descriptionGroup.alpha -= Time.deltaTime * 15f;
				}
				else
				{
					_visibleDescriptionSerial = _highlightedSerial;
				}
				return;
			}
			RadialDescriptionBase[] descriptionTypes = _descriptionTypes;
			foreach (RadialDescriptionBase radialDescriptionBase in descriptionTypes)
			{
				bool flag = radialDescriptionBase.DescriptionType == value.DescriptionType;
				radialDescriptionBase.gameObject.SetActive(flag);
				if (flag)
				{
					radialDescriptionBase.UpdateInfo(value, _circleColor.Color);
				}
			}
			if (_descriptionGroup.alpha < 1f)
			{
				_descriptionGroup.alpha += Time.deltaTime * 15f;
			}
		}

		public void ItemsModified(Inventory targetInventory)
		{
			for (int i = 0; i < OrganizedContent.Length; i++)
			{
				if (OrganizedContent[i] > 0 && !targetInventory.UserInventory.Items.ContainsKey(OrganizedContent[i]))
				{
					OrganizedContent[i] = 0;
				}
			}
			foreach (KeyValuePair<ushort, ItemBase> item in targetInventory.UserInventory.Items)
			{
				if (OrganizedContent.Contains(item.Key))
				{
					continue;
				}
				for (int j = 0; j < OrganizedContent.Length; j++)
				{
					if (OrganizedContent[j] == 0)
					{
						OrganizedContent[j] = item.Key;
						break;
					}
				}
			}
		}

		public void AmmoModified(ReferenceHub hub)
		{
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			bool flag = false;
			if (_prevRole != currentRole.RoleTypeId)
			{
				flag = true;
				_prevRole = currentRole.RoleTypeId;
			}
			foreach (KeyValuePair<ItemType, AmmoElement> item in _organizedAmmo)
			{
				if (flag)
				{
					UnityEngine.Object.Destroy(item.Value.gameObject);
				}
				else
				{
					item.Value.gameObject.SetActive(value: false);
				}
			}
			if (flag)
			{
				_organizedAmmo.Clear();
			}
			Color roleColor = currentRole.RoleColor;
			foreach (KeyValuePair<ItemType, ushort> item2 in hub.inventory.UserInventory.ReserveAmmo)
			{
				if (!_organizedAmmo.TryGetValue(item2.Key, out var value))
				{
					value = UnityEngine.Object.Instantiate(_ammoElementTemplate);
					value.transform.SetParent(_ammoElementTemplate.transform.parent);
					value.transform.localScale = Vector3.one;
					value.Setup(item2.Key, roleColor);
					_organizedAmmo[item2.Key] = value;
				}
				value.UpdateAmount(item2.Value);
			}
		}

		private void RefreshItemColors(Inventory inv, bool invNull)
		{
			_highlightedSerial = 0;
			if (_slots == null)
			{
				return;
			}
			for (int i = 0; i < _slots.Length; i++)
			{
				bool flag = (_dragCursorIcon.enabled ? _draggedId : base.HighlightedSlot) == i;
				Color b;
				if (OrganizedContent[i] > 0 && !invNull && inv.UserInventory.Items.TryGetValue(OrganizedContent[i], out var value))
				{
					bool flag2 = OrganizedContent[i] == inv.CurItem.SerialNumber;
					Color color = ((value is IWearableItem { IsWorn: not false }) ? _wornColor.Color : (value.AllowEquip ? Color.clear : _blockedColor.Color));
					b = ((flag2 | flag) ? Color.Lerp(_heldColor.Color, _highlightColor.Color, (!flag) ? 0f : (flag2 ? 0.5f : 1f)) : color);
					_slots[i].UpdateVisuals(value);
					if (flag)
					{
						_highlightedSerial = OrganizedContent[i];
					}
				}
				else
				{
					if ((invNull & flag) && OrganizedContent[i] > 0)
					{
						b = _highlightColor.Color;
						_highlightedSerial = OrganizedContent[i];
					}
					else
					{
						b = Color.clear;
					}
					if (!invNull)
					{
						_slots[i].UpdateVisuals(null);
					}
				}
				Image highlightSafe = GetHighlightSafe(i);
				highlightSafe.color = Color.Lerp(highlightSafe.color, b, 15f * Time.deltaTime);
			}
		}
	}
}
