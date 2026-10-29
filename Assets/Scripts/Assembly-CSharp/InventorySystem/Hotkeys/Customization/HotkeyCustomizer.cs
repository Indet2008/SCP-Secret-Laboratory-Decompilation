using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UserSettings.GUIElements;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyCustomizer : MonoBehaviour
	{
		[SerializeField]
		private TMP_Text _titleField;

		[SerializeField]
		private TMP_InputField _nameInputField;

		[SerializeField]
		private KeycodeField _keycodeField;

		[SerializeField]
		private TMP_Dropdown _apperance;

		[SerializeField]
		private TMP_Dropdown _sortMode;

		[SerializeField]
		private HotkeyPool _itemPool;

		[SerializeField]
		private HotkeyPool _orderPool;

		[SerializeField]
		private TMP_Dropdown _overrideOption;

		[SerializeField]
		private HotkeysTranslation[] _sortModeTranslations;

		private byte _lastTranslationId;

		private bool _usesCustomName;

		private HotkeyListGenerator _spawnedBy;

		private UserSettingsFoldoutGroup _foldoutGroup;

		private readonly List<HotkeyOverrideBase> _availableOverrides = new List<HotkeyOverrideBase>();

		private readonly Dictionary<TMP_Dropdown, bool> _prevDropdownStates = new Dictionary<TMP_Dropdown, bool>();

		private PoolElementData[] CombinedPoolData
		{
			get
			{
				List<PoolElementData> elements = _itemPool.Elements;
				List<PoolElementData> elements2 = _orderPool.Elements;
				PoolElementData[] array = new PoolElementData[elements2.Count + elements.Count];
				Array.Copy(elements.ToArray(), 0, array, 0, elements.Count);
				Array.Copy(elements2.ToArray(), 0, array, elements.Count, elements2.Count);
				return array;
			}
			set
			{
				_itemPool.Elements.Clear();
				_orderPool.Elements.Clear();
				for (int i = 0; i < value.Length; i++)
				{
					PoolElementData item = value[i];
					switch (item.Type)
					{
					case PoolElementData.ElementType.SpecificItem:
					case PoolElementData.ElementType.Group:
						_itemPool.Elements.Add(item);
						break;
					case PoolElementData.ElementType.Order:
						_orderPool.Elements.Add(item);
						break;
					}
				}
			}
		}

		public bool IsModified { get; internal set; }

		private void SetTitle(string str)
		{
			_titleField.text = string.Format(Translations.Get(HotkeysTranslation.TitlePrefix), str);
		}

		private void Awake()
		{
			_keycodeField.OnKeySet += delegate
			{
				IsModified = true;
			};
			_itemPool.OnModified += OnItemsModified;
			_orderPool.OnModified += OnOrderModified;
			_apperance.onValueChanged.AddListener(delegate
			{
				IsModified = true;
			});
			_overrideOption.onValueChanged.AddListener(delegate
			{
				IsModified = true;
			});
			_sortMode.onValueChanged.AddListener(OnSortModeEdited);
			_nameInputField.onEndEdit.AddListener(OnNameEdited);
			_foldoutGroup = GetComponent<UserSettingsFoldoutGroup>();
			_foldoutGroup.FoldInstantly();
		}

		private void OnDisable()
		{
			_foldoutGroup.FoldInstantly();
		}

		private void Update()
		{
			RebuildHintsForDropdown(_sortMode, delegate(List<UserSettingsEntryDescription> list)
			{
				for (int i = 0; i < list.Count; i++)
				{
					list[i].SetTranslation(_sortModeTranslations[i]);
				}
			});
			RebuildHintsForDropdown(_overrideOption, delegate(List<UserSettingsEntryDescription> list)
			{
				int num = 0;
				foreach (UserSettingsEntryDescription item in list)
				{
					if (!item.UsesReplacer)
					{
						HotkeysTranslation? description = _availableOverrides[num].Description;
						if (description.HasValue)
						{
							item.SetTranslation(description.Value);
						}
						else
						{
							item.gameObject.SetActive(value: false);
						}
						num++;
					}
				}
			});
		}

		// Assigns tooltips to the dropdown's option entries once, right after it gets expanded.
		private void RebuildHintsForDropdown(TMP_Dropdown dropdown, Action<List<UserSettingsEntryDescription>> action)
		{
			bool value;
			bool flag = _prevDropdownStates.TryGetValue(dropdown, out value);
			bool isExpanded = dropdown.IsExpanded;
			_prevDropdownStates[dropdown] = isExpanded;
			if (!(flag && value) && isExpanded)
			{
				List<UserSettingsEntryDescription> list = ListPool<UserSettingsEntryDescription>.Shared.Rent();
				dropdown.gameObject.GetComponentsInChildren(list);
				action(list);
				ListPool<UserSettingsEntryDescription>.Shared.Return(list);
			}
		}

		private void OnNameEdited(string str)
		{
			_lastTranslationId = 0;
			_usesCustomName = !string.IsNullOrWhiteSpace(str);
			SetTitle(ToSavedHotkey().DisplayName);
			IsModified = true;
		}

		private void OnSortModeEdited(int mode)
		{
			IsModified = true;
			GameObject gameObject = _orderPool.transform.parent.gameObject;
			switch (mode)
			{
			case 0:
				gameObject.SetActive(value: false);
				break;
			case 1:
				gameObject.SetActive(value: true);
				if (_orderPool.Elements.IsEmpty())
				{
					for (int i = 0; i < 3; i++)
					{
						_orderPool.Elements.Add(new PoolElementData(i));
					}
				}
				break;
			}
			LayoutRebuilder.ForceRebuildLayoutImmediate(base.transform.parent as RectTransform);
			_foldoutGroup.RefreshSize();
		}

		private void OnItemsModified()
		{
			IsModified = true;
			HotkeyOverrideOption prevOption = ((_availableOverrides.Count != 0) ? _availableOverrides[_overrideOption.value].OptionType : HotkeyOverrideOption.NoOverride);
			UpdateAvailableOverrides(prevOption);
		}

		private void OnOrderModified()
		{
			IsModified = true;
			if (_orderPool.Elements.Count <= 0)
			{
				_sortMode.value = 0;
			}
		}

		private void UpdateAvailableOverrides(HotkeyOverrideOption prevOption)
		{
			_availableOverrides.Clear();
			_overrideOption.ClearOptions();
			int input = 0;
			HotkeyOverrideBase[] overrides = HotkeyOverrideBase.Overrides;
			foreach (HotkeyOverrideBase hotkeyOverrideBase in overrides)
			{
				if (hotkeyOverrideBase.CheckAvailability(_itemPool.Elements))
				{
					if (hotkeyOverrideBase.OptionType == prevOption)
					{
						input = _availableOverrides.Count;
					}
					_overrideOption.options.Add(new TMP_Dropdown.OptionData(Translations.Get(hotkeyOverrideBase.OptionName)));
					_availableOverrides.Add(hotkeyOverrideBase);
				}
			}
			_overrideOption.value = input;
			_overrideOption.RefreshShownValue();
		}

		public void RemoveSelf()
		{
			_spawnedBy.RemoveInstance(this);
		}

		public SavedHotkey ToSavedHotkey()
		{
			int value = _overrideOption.value;
			return new SavedHotkey
			{
				CustomName = (_usesCustomName ? _nameInputField.text : null),
				TranslationId = (byte)((!_usesCustomName) ? _lastTranslationId : 0),
				AssignedKey = _keycodeField.CurDisplayedKey,
				Apperance = (HotkeyApperance)_apperance.value,
				SortMode = (HotkeySortMode)_sortMode.value,
				OverrideOption = ((value >= 0 && value < _availableOverrides.Count) ? _availableOverrides[value].OptionType : HotkeyOverrideOption.NoOverride),
				Elements = CombinedPoolData
			};
		}

		public void Load(SavedHotkey data, HotkeyListGenerator spawnedBy)
		{
			SetTitle(data.DisplayName);
			_spawnedBy = spawnedBy;
			_nameInputField.SetTextWithoutNotify(data.DisplayName);
			_keycodeField.SetDisplayedKey(data.AssignedKey);
			_apperance.SetValueWithoutNotify((int)data.Apperance);
			_sortMode.value = (int)data.SortMode;
			_lastTranslationId = data.TranslationId;
			_usesCustomName = !string.IsNullOrEmpty(data.CustomName);
			CombinedPoolData = data.Elements ?? new PoolElementData[0];
			IsModified = false;
			UpdateAvailableOverrides(data.OverrideOption);
		}
	}
}
