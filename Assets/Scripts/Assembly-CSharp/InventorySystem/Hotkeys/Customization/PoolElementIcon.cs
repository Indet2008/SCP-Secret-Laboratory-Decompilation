using System;
using System.Collections.Generic;
using InventorySystem.Items;
using NorthwoodLib.Pools;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys.Customization
{
	public class PoolElementIcon : MonoBehaviour
	{
		private PoolElementData? _data;

		[SerializeField]
		private GameObject[] _roots;

		[SerializeField]
		private RawImage _specificItemIcon;

		[SerializeField]
		private List<RectTransform> _groupRows;

		[SerializeField]
		private List<RawImage> _groupIcons;

		[SerializeField]
		private TMP_Text _orderText;

		[SerializeField]
		private GameObject _addElement;

		public Vector3 Position
		{
			get
			{
				return base.transform.position;
			}
			set
			{
				base.transform.position = value;
			}
		}

		public PoolElementData Data
		{
			get
			{
				return _data.Value;
			}
			set
			{
				if (!_data.HasValue || !_data.Value.Equals(value))
				{
					_data = value;
					UpdateAnyIcon();
				}
			}
		}

		public void MarkAsAddButton()
		{
			_roots.ForEach(delegate(GameObject x)
			{
				x.SetActive(value: false);
			});
			_addElement.SetActive(value: true);
			_data = null;
		}

		private void UpdateAnyIcon()
		{
			PoolElementData value = _data.Value;
			for (int i = 0; i < _roots.Length; i++)
			{
				_roots[i].SetActive(i == (int)value.Type);
			}
			switch (value.Type)
			{
			case PoolElementData.ElementType.SpecificItem:
				SetupSpecificIcon(value.SpecificItem);
				break;
			case PoolElementData.ElementType.Group:
				SetupGroupIcon(value.Group);
				break;
			case PoolElementData.ElementType.Order:
				SetupOrderIcon(value.Order);
				break;
			}
			_addElement.SetActive(value: false);
		}

		private void SetupSpecificIcon(ItemType it)
		{
			if (InventoryItemLoader.TryGetItem<ItemBase>(it, out var result))
			{
				_specificItemIcon.texture = result.Icon;
			}
		}

		// Item icons of the group laid out in a square grid (rows duplicated from the first row template).
		private void SetupGroupIcon(HotkeyItemGroup group)
		{
			DeactivateAll(_groupIcons);
			DeactivateAll(_groupRows);
			_addElement.SetActive(value: false);
			List<Texture> list = ListPool<Texture>.Shared.Rent();
			ItemType[] items = group.GetItems();
			for (int i = 0; i < items.Length; i++)
			{
				if (InventoryItemLoader.TryGetItem<ItemBase>(items[i], out var result))
				{
					list.Add(result.Icon);
				}
			}
			int count = list.Count;
			if (count == 0)
			{
				ListPool<Texture>.Shared.Return(list);
				return;
			}
			int num = 1;
			while (num * num < count)
			{
				num++;
			}
			float num2 = _specificItemIcon.rectTransform.rect.width / (float)num;
			for (int j = 0; j < count; j++)
			{
				int index = (int)Math.Floor((float)j / (float)num);
				RectTransform orDuplicate = GetOrDuplicate(_groupRows, index);
				RawImage orDuplicate2 = GetOrDuplicate(_groupIcons, j);
				orDuplicate2.texture = list[j];
				orDuplicate2.rectTransform.SetParent(orDuplicate, worldPositionStays: true);
				orDuplicate2.rectTransform.sizeDelta = Vector2.one * num2;
			}
			ListPool<Texture>.Shared.Return(list);
			LayoutRebuilder.ForceRebuildLayoutImmediate(_groupRows[0].parent as RectTransform);
		}

		private T GetOrDuplicate<T>(List<T> targetList, int index, bool includeChildren = false) where T : Component
		{
			while (index >= targetList.Count)
			{
				T val = targetList[targetList.Count - 1];
				GameObject gameObject = UnityEngine.Object.Instantiate(val.gameObject, val.transform.parent);
				targetList.Add(gameObject.GetComponent<T>());
				if (!includeChildren)
				{
					Transform transform = gameObject.transform;
					for (int i = 0; i < transform.childCount; i++)
					{
						UnityEngine.Object.Destroy(transform.GetChild(i).gameObject);
					}
				}
			}
			T val2 = targetList[index];
			val2.gameObject.SetActive(value: true);
			return val2;
		}

		private void DeactivateAll<T>(List<T> comp) where T : Component
		{
			comp.ForEach(delegate(T x)
			{
				x.gameObject.SetActive(value: false);
			});
		}

		private void SetupOrderIcon(int order)
		{
			_orderText.text = (order + 1).ToString();
		}
	}
}
