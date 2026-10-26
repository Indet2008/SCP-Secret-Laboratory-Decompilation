using System.Collections.Generic;
using System.Linq;
using InventorySystem;
using InventorySystem.Items;
using MEC;
using RemoteAdmin.Elements;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Menus
{
	public class InventoryMenu : RaCommandMenu
	{
		public struct PrintedItem
		{
			public GameObject GameObject { get; internal set; }

			public ItemType Type { get; internal set; }

			public ItemCategory Category { get; internal set; }

			public string Name { get; internal set; }

			public PrintedItem(GameObject obj, ItemType itemType, ItemCategory itemCategory, string name)
			{
				GameObject = obj;
				Type = itemType;
				Category = itemCategory;
				Name = name;
			}

			public override string ToString()
			{
				return Name;
			}
		}

		[SerializeField]
		private Transform _parent;

		[SerializeField]
		private GameObject _template;

		[SerializeField]
		private TMP_Dropdown _dropdown;

		[SerializeField]
		private TMP_InputField _itemSearchInput;

		[SerializeField]
		private float _searchAnimSpeed = 0.0185f;

		private CoroutineHandle _searchAnimHandle;

		private readonly List<PrintedItem> _printedItems = new List<PrintedItem>();

		public static bool DescendingItemOrder { get; set; }

		public void ForceReorder()
		{
			if (_printedItems.Count == 0)
			{
				return;
			}
			int num = ((_dropdown != null) ? _dropdown.value : 0);
			IEnumerable<PrintedItem> source = num switch
			{
				1 => _printedItems.OrderBy((PrintedItem x) => x.Category).ThenBy((PrintedItem x) => x.Type), 
				2 => _printedItems.OrderBy((PrintedItem x) => x.Name), 
				_ => _printedItems.OrderBy((PrintedItem x) => x.Type), 
			};
			if (DescendingItemOrder)
			{
				source = source.Reverse();
			}
			int num2 = 0;
			foreach (PrintedItem item in source)
			{
				if (item.GameObject != null)
				{
					item.GameObject.transform.SetSiblingIndex(num2++);
				}
			}
		}

		public void AnimatedSearch(string query)
		{
			Timing.KillCoroutines(_searchAnimHandle);
			_searchAnimHandle = Timing.RunCoroutine(SearchAnimation(query ?? string.Empty));
		}

		private IEnumerator<float> SearchAnimation(string query)
		{
			int changed = 0;
			foreach (PrintedItem printedItem in _printedItems)
			{
				if (!(printedItem.GameObject == null))
				{
					bool flag = string.IsNullOrEmpty(query) || printedItem.Name.IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0 || printedItem.Type.ToString().IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0;
					if (printedItem.GameObject.activeSelf != flag)
					{
						printedItem.GameObject.SetActive(flag);
						if (++changed % 3 == 0)
						{
							yield return Timing.WaitForSeconds(_searchAnimSpeed);
						}
					}
				}
			}
		}

		protected override void OnStart()
		{
			if (_itemSearchInput != null)
			{
				_itemSearchInput.onValueChanged.AddListener(AnimatedSearch);
			}
			if (_template == null || _parent == null)
			{
				return;
			}
			ValueButton componentInChildren4 = _template.GetComponentInChildren<ValueButton>(includeInactive: true);
			if (componentInChildren4 != null)
			{
				base.Options.Remove(componentInChildren4);
			}
			_template.SetActive(value: false);
			foreach (KeyValuePair<ItemType, ItemBase> availableItem in InventoryItemLoader.AvailableItems)
			{
				ItemBase value = availableItem.Value;
				if (!(value == null))
				{
					GameObject gameObject = Object.Instantiate(_template, _parent);
					gameObject.transform.localScale = Vector3.one;
					gameObject.SetActive(value: true);
					gameObject.name = value.name;
					RawImage componentInChildren = gameObject.GetComponentInChildren<RawImage>(includeInactive: true);
					if (componentInChildren != null)
					{
						componentInChildren.texture = value.Icon;
						componentInChildren.color = ((value.Icon != null) ? Color.white : Color.clear);
					}
					if (value.Icon == null)
					{
						TMP_Text componentInChildren3 = gameObject.GetComponentInChildren<TMP_Text>(includeInactive: true);
						if (componentInChildren3 != null)
						{
							componentInChildren3.gameObject.SetActive(value: true);
							componentInChildren3.text = availableItem.Key.ToString();
						}
					}
					ValueButton componentInChildren2 = gameObject.GetComponentInChildren<ValueButton>(includeInactive: true);
					if (componentInChildren2 != null)
					{
						componentInChildren2.CommandMenu = this;
						componentInChildren2.Value = (int)availableItem.Key + ".";
						if (!base.Options.Contains(componentInChildren2))
						{
							base.Options.Add(componentInChildren2);
						}
					}
					string text = availableItem.Key.GetName();
					if (string.IsNullOrEmpty(text) || text == "NO_TRANSLATION")
					{
						text = value.name;
					}
					_printedItems.Add(new PrintedItem(gameObject, availableItem.Key, value.Category, text));
				}
			}
			ForceReorder();
		}
	}
}