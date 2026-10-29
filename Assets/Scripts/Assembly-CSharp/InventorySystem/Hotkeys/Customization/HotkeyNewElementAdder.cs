using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using InventorySystem.Items;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyNewElementAdder : MonoBehaviour
	{
		private struct ItemElement
		{
			private readonly GameObject _go;

			private readonly TMP_Text _text;

			private readonly RawImage _icon;

			private readonly Button _button;

			private readonly Texture _defIcon;

			public PoolElementData Data { get; private set; }

			public ItemElement(GameObject newInst, Texture defaultIcon)
			{
				_go = newInst;
				_defIcon = defaultIcon;
				Data = default(PoolElementData);
				_text = newInst.GetComponentInChildren<TMP_Text>();
				_icon = newInst.GetComponentInChildren<RawImage>();
				_button = newInst.GetComponentInChildren<Button>();
			}

			public readonly void Disable()
			{
				_go.SetActive(value: false);
			}

			public bool TryEnable(PoolElementData data, TMP_InputField filter, Action<PoolElementData> callback)
			{
				_go.SetActive(value: true);
				Data = data;
				switch (data.Type)
				{
				case PoolElementData.ElementType.Order:
					_text.text = (data.Order + 1).ToString();
					_icon.texture = _defIcon;
					break;
				case PoolElementData.ElementType.Group:
					_text.text = data.Group.GetTranslation();
					_icon.texture = _defIcon;
					break;
				case PoolElementData.ElementType.SpecificItem:
				{
					ItemBase itemBase = InventoryItemLoader.AvailableItems[data.SpecificItem];
					_text.text = ((itemBase is IItemNametag itemNametag) ? itemNametag.Name : itemBase.ItemTypeId.ToString());
					_icon.texture = itemBase.Icon;
					break;
				}
				}
				_button.onClick.RemoveAllListeners();
				_button.onClick.AddListener(delegate
				{
					callback(data);
				});
				return CheckFilter(filter.text);
			}

			private readonly bool CheckFilter(string filter)
			{
				if (string.IsNullOrWhiteSpace(filter))
				{
					return true;
				}
				return CultureInfo.InvariantCulture.CompareInfo.IndexOf(_text.text, filter, CompareOptions.IgnoreCase) >= 0;
			}
		}

		[SerializeField]
		private RectTransform _elementTemplate;

		[SerializeField]
		private Texture _defaultIcon;

		[SerializeField]
		private TMP_InputField _searchBar;

		[SerializeField]
		private PoolElementData.ElementType[] _types;

		[SerializeField]
		private HotkeyPool _pool;

		private int _elementClock;

		private Canvas _canvas;

		private readonly List<ItemElement> _elementPool = new List<ItemElement>();

		private void Awake()
		{
			_canvas = GetComponentInParent<Canvas>();
			_searchBar.onValueChanged.AddListener(delegate
			{
				UpdateList();
			});
		}

		// Opens next to the cursor, kept inside the screen.
		private void OnEnable()
		{
			RectTransform rectTransform = base.transform as RectTransform;
			Rect rect = rectTransform.rect;
			Vector3 mousePosition = Input.mousePosition;
			float scaleFactor = _canvas.scaleFactor;
			float num = rect.width * scaleFactor + mousePosition.x;
			float num2 = (0f - rect.height) * scaleFactor + mousePosition.y;
			float x = mousePosition.x;
			float y = mousePosition.y;
			if (num > (float)Screen.width)
			{
				x = (float)Screen.width - num + mousePosition.x;
			}
			if (0f > num2)
			{
				y = mousePosition.y - num2;
			}
			rectTransform.position = new Vector3(x, y, 0f);
			_searchBar.SetTextWithoutNotify(string.Empty);
			UpdateList();
		}

		private void OnDisable()
		{
			if (base.gameObject.activeSelf)
			{
				base.gameObject.SetActive(value: false);
			}
		}

		private void Update()
		{
			_searchBar.Select();
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				base.gameObject.SetActive(value: false);
			}
		}

		private void OnOptionSelected(PoolElementData data)
		{
			base.gameObject.SetActive(value: false);
			_pool.Elements.Add(data);
		}

		private void UpdateList()
		{
			_elementClock = 0;
			_types.ForEach(AddElementsOfType);
			for (int i = _elementClock; i < _elementPool.Count; i++)
			{
				_elementPool[i].Disable();
			}
		}

		private void AddElementsOfType(PoolElementData.ElementType type)
		{
			switch (type)
			{
			case PoolElementData.ElementType.SpecificItem:
				AddAllSpecificItems();
				break;
			case PoolElementData.ElementType.Group:
				AddAllGroups();
				break;
			case PoolElementData.ElementType.Order:
				AddAllOrders();
				break;
			}
		}

		private void AddAllGroups()
		{
			HotkeyItemGroup[] values = EnumUtils<HotkeyItemGroup>.Values;
			for (int i = 0; i < values.Length; i++)
			{
				AddElement(new PoolElementData(values[i]));
			}
		}

		private void AddAllSpecificItems()
		{
			foreach (KeyValuePair<ItemType, ItemBase> item in InventoryItemLoader.AvailableItems.OrderBy((KeyValuePair<ItemType, ItemBase> x) => x.Value.Category))
			{
				if (item.Value.IsHotkeyable())
				{
					AddElement(new PoolElementData(item.Key));
				}
			}
		}

		private void AddAllOrders()
		{
			for (int i = 0; i < 8; i++)
			{
				AddElement(new PoolElementData(i));
			}
		}

		private void AddElement(PoolElementData data)
		{
			if (_pool.Elements.Count > 0 && _pool.Elements.Contains(data))
			{
				return;
			}
			while (_elementClock >= _elementPool.Count)
			{
				RectTransform rectTransform = UnityEngine.Object.Instantiate(_elementTemplate, _elementTemplate.parent);
				_elementPool.Add(new ItemElement(rectTransform.gameObject, _defaultIcon));
			}
			ItemElement value = _elementPool[_elementClock];
			if (value.TryEnable(data, _searchBar, OnOptionSelected))
			{
				_elementPool[_elementClock] = value;
				_elementClock++;
			}
		}
	}
}
