using System.Collections.Generic;
using System.Diagnostics;
using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Hotkeys
{
	public class HotkeyHud : MonoBehaviour
	{
		private struct HotkeyToDisplay
		{
			public ItemBase Item;

			public HotkeyApperance Apperance;

			public KeyCode Key;

			public bool IsNew;
		}

		[SerializeField]
		private CanvasGroup _fadeGroup;

		[SerializeField]
		private List<HotkeyIconBase> _iconTemplates;

		[SerializeField]
		private RectTransform _iconParent;

		[SerializeField]
		private RectTransform _ellipsisIndicator;

		[SerializeField]
		private float _spacing;

		[SerializeField]
		private float _maxWidth;

		private readonly List<HotkeyToDisplay> _hotkeysToDisplay = new List<HotkeyToDisplay>();

		private readonly List<HotkeyIconBase> _iconInstances = new List<HotkeyIconBase>();

		private readonly Stopwatch _fadeoutStopwatch = new Stopwatch();

		private bool[] _prevEmpty = new bool[0];

		private float _prevAlpha;

		private float _totalWidth;

		private Color _lastColor;

		private const float FadeoutTime = 5.5f;

		private const float FadeoutMaxSpeed = 1.2f;

		private const float FadeoutMinSpeed = 0.05f;

		private const float FadeinSpeed = 2f;

		private void Start()
		{
			PlayerRoleManager.OnRoleChanged += UpdateColors;
			HotkeyInterpreter.OnHotkeysRevalidated += UpdateHotkeys;
			HotkeyController.OnHotkeyTriggered += OnHotkeyTriggered;
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= UpdateColors;
			HotkeyInterpreter.OnHotkeysRevalidated -= UpdateHotkeys;
			HotkeyController.OnHotkeyTriggered -= OnHotkeyTriggered;
		}

		private void Update()
		{
			_iconInstances.ForEach(delegate(HotkeyIconBase x)
			{
				x.UpdateAnimations();
			});
		}

		private void UpdateColors(ReferenceHub rh, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (rh.isLocalPlayer)
			{
				_lastColor = newRole.RoleColor;
				_iconInstances.ForEach(delegate(HotkeyIconBase x)
				{
					x.SetColors(_lastColor);
				});
			}
		}

		private void RefreshAlpha()
		{
			if (!HotkeyController.AllowActivation)
			{
				_fadeGroup.alpha = 0f;
				return;
			}
			float prevAlpha = _prevAlpha;
			prevAlpha = ((!(_fadeoutStopwatch.Elapsed.TotalSeconds < 5.5)) ? (prevAlpha - Time.deltaTime * ((prevAlpha + 0.05f) * 1.2f)) : (prevAlpha + Time.deltaTime * 2f));
			prevAlpha = Mathf.Clamp01(prevAlpha);
			_fadeGroup.alpha = prevAlpha;
			_prevAlpha = prevAlpha;
		}

		private void UpdateHotkeys()
		{
			RefreshAlpha();
			int count = HotkeyStorage.Hotkeys.Count;
			if (count != _prevEmpty.Length)
			{
				_prevEmpty = new bool[count];
			}
			_hotkeysToDisplay.Clear();
			for (int num = count - 1; num >= 0; num--)
			{
				if (HotkeyInterpreter.TryGetItem(num, out var ib))
				{
					SavedHotkey savedHotkey = HotkeyStorage.Hotkeys[num];
					HotkeyToDisplay item = new HotkeyToDisplay
					{
						Item = ib,
						Apperance = savedHotkey.Apperance,
						Key = savedHotkey.AssignedKey,
						IsNew = _prevEmpty[num]
					};
					_prevEmpty[num] = false;
					_hotkeysToDisplay.Add(item);
				}
				else
				{
					_prevEmpty[num] = true;
				}
			}
			_totalWidth = 0f;
			_iconInstances.ForEach(delegate(HotkeyIconBase x)
			{
				x.gameObject.SetActive(value: false);
			});
			DisplayHotkeys(HotkeyApperance.NormalIcon);
			DisplayHotkeys(HotkeyApperance.SmallIcon);
		}

		private void DisplayHotkeys(HotkeyApperance targetType)
		{
			foreach (HotkeyToDisplay item in _hotkeysToDisplay)
			{
				if (item.Apperance == targetType)
				{
					SpawnIcon(item);
				}
			}
		}

		private void SpawnIcon(HotkeyToDisplay htd)
		{
			HotkeyIconBase hotkeyIconBase = null;
			foreach (HotkeyIconBase iconTemplate in _iconTemplates)
			{
				if (iconTemplate.CheckCompatibility(htd.Item, htd.Apperance))
				{
					hotkeyIconBase = iconTemplate;
					break;
				}
			}
			if (hotkeyIconBase == null)
			{
				return;
			}
			HotkeyIconBase hotkeyIconBase2 = null;
			foreach (HotkeyIconBase iconInstance in _iconInstances)
			{
				if (!iconInstance.gameObject.activeSelf && iconInstance.GetType() == hotkeyIconBase.GetType() && iconInstance.CheckCompatibility(htd.Item, htd.Apperance))
				{
					hotkeyIconBase2 = iconInstance;
					break;
				}
			}
			if (hotkeyIconBase2 == null)
			{
				hotkeyIconBase2 = Object.Instantiate(hotkeyIconBase, _iconParent);
				hotkeyIconBase2.SetColors(_lastColor);
				_iconInstances.Add(hotkeyIconBase2);
			}
			hotkeyIconBase2.Key = htd.Key;
			hotkeyIconBase2.SetItem(htd.Item);
			hotkeyIconBase2.gameObject.SetActive(value: true);
			RectTransform rectTransform = hotkeyIconBase2.transform as RectTransform;
			GameObject gameObject = _ellipsisIndicator.gameObject;
			rectTransform.anchoredPosition = Vector2.left * _totalWidth;
			_totalWidth += rectTransform.sizeDelta.x + _spacing;
			if (_totalWidth > _maxWidth)
			{
				hotkeyIconBase2.gameObject.SetActive(value: false);
				if (!gameObject.activeSelf)
				{
					gameObject.SetActive(value: true);
					_ellipsisIndicator.anchoredPosition = rectTransform.anchoredPosition;
				}
			}
			else
			{
				gameObject.SetActive(value: false);
				if (htd.IsNew)
				{
					hotkeyIconBase2.PlayHighlightAnimation();
					_fadeoutStopwatch.Restart();
				}
			}
		}

		private void OnHotkeyTriggered(int hotkeyIndex, ItemBase ib)
		{
			KeyCode assignedKey = HotkeyStorage.Hotkeys[hotkeyIndex].AssignedKey;
			foreach (HotkeyIconBase iconInstance in _iconInstances)
			{
				if (iconInstance.Key == assignedKey && iconInstance.gameObject.activeSelf)
				{
					iconInstance.PlayHighlightAnimation();
				}
			}
			_fadeoutStopwatch.Restart();
		}
	}
}
