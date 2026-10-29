using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyPool : MonoBehaviour
	{
		[SerializeField]
		private Rect _dragRect;

		[SerializeField]
		private Rect _deleteRect;

		[SerializeField]
		private float _dragLerp;

		[SerializeField]
		private float _heightLerp;

		[SerializeField]
		private PoolElementIcon _iconTemplate;

		[SerializeField]
		private RectTransform _dragIcon;

		[SerializeField]
		private RectTransform _deleteIcon;

		[SerializeField]
		private GameObject _addNewElementWindow;

		[SerializeField]
		private RectTransform _poolRt;

		[SerializeField]
		private float _gridCellSize;

		[SerializeField]
		private float _poolHeightPadding;

		[SerializeField]
		private LayoutElement _poolHeightRect;

		private readonly List<PoolElementData> _prevElements = new List<PoolElementData>();

		private readonly Dictionary<PoolElementData, Vector3> _prevPositions = new Dictionary<PoolElementData, Vector3>();

		private readonly List<PoolElementIcon> _icons = new List<PoolElementIcon>();

		private Canvas _canvas;

		private List<PoolElementData> _elements;

		private int? _deleteTarget;

		private int? _prevDragTarget;

		private ScrollRect _scrollRect;

		private const float UpdateFitterLayoutThreshold = 0.05f;

		public List<PoolElementData> Elements
		{
			get
			{
				return _elements ?? (_elements = new List<PoolElementData>());
			}
			set
			{
				_elements = value;
				_prevElements.Clear();
				_prevElements.AddRange(Elements);
			}
		}

		// Mouse position inside the pool grid, in cells (x right, y down).
		private Vector2 NormalizedMousePos
		{
			get
			{
				Vector3 position = _poolRt.position;
				Vector3 mousePosition = Input.mousePosition;
				float scaleFactor = _canvas.scaleFactor;
				float num = (position.x - mousePosition.x) / scaleFactor;
				float num2 = (position.y - mousePosition.y) / scaleFactor;
				Rect rect = _poolRt.rect;
				Rect rect2 = _poolRt.rect;
				return new Vector2((rect.width * 0.5f + (0f - num)) / _gridCellSize, (rect2.height * 0.5f + num2) / _gridCellSize);
			}
		}

		private int? DragTarget
		{
			get
			{
				return _prevDragTarget;
			}
			set
			{
				if (value == _prevDragTarget)
				{
					return;
				}
				_prevDragTarget = value;
				if (!(_scrollRect == null) || base.transform.TryGetComponentInParent<ScrollRect>(out _scrollRect))
				{
					if (!_prevDragTarget.HasValue)
					{
						ButtonAudioSource.PlayClick();
						_scrollRect.enabled = true;
					}
					else
					{
						ButtonAudioSource.PlayHover();
						_scrollRect.enabled = false;
					}
				}
			}
		}

		private int ItemsPerRow => Mathf.FloorToInt(_poolRt.rect.width / _gridCellSize);

		private int UsedRows => Mathf.CeilToInt((float)(Elements.Count + 1) / (float)ItemsPerRow);

		public event Action OnModified;

		private void Awake()
		{
			_canvas = GetComponentInParent<Canvas>();
		}

		private void OnEnable()
		{
			UpdateLayout(instant: true);
		}

		private void OnDisable()
		{
			_deleteTarget = null;
			DragTarget = null;
		}

		private void Update()
		{
			if (Input.GetMouseButtonDown(0))
			{
				OnLmbDown();
			}
			if (Input.GetMouseButton(0))
			{
				UpdateLmbHolding();
			}
			if (Input.GetMouseButtonUp(0))
			{
				OnLmbReleased();
			}
			UpdateLayout(instant: false);
			UpdateDragIcon();
		}

		private void OnLmbDown()
		{
			Vector2 normalizedMousePos = NormalizedMousePos;
			int num = Mathf.FloorToInt(normalizedMousePos.x);
			int num2 = Mathf.FloorToInt(normalizedMousePos.y);
			if (num < 0 || num2 < 0 || num >= ItemsPerRow || num2 >= UsedRows)
			{
				return;
			}
			Vector2 point = normalizedMousePos - new Vector2(num, num2);
			int num3 = num2 * ItemsPerRow + num;
			if (num3 > Elements.Count)
			{
				return;
			}
			EventSystem current = EventSystem.current;
			if (current.currentSelectedGameObject != null)
			{
				return;
			}
			if (num3 == Elements.Count)
			{
				_addNewElementWindow.SetActive(value: true);
			}
			else if (_deleteRect.Contains(point))
			{
				_deleteTarget = num3;
			}
			else if (_dragRect.Contains(point))
			{
				DragTarget = num3;
				_icons[num3].transform.SetAsLastSibling();
			}
		}

		private void OnLmbReleased()
		{
			DragTarget = null;
			if (_deleteTarget.HasValue)
			{
				int value = _deleteTarget.Value;
				_deleteTarget = null;
				if (TryGetHighlightedElement(out var index, out var relativePos, clamp: true) && index == value && _deleteRect.Contains(relativePos))
				{
					RemoveElement(index);
				}
			}
		}

		private void UpdateLmbHolding()
		{
			if (!DragTarget.HasValue)
			{
				return;
			}
			int value = DragTarget.Value;
			if (TryGetHighlightedElement(out var index, out var _, clamp: true))
			{
				int num = Mathf.Min(index, Elements.Count - 1);
				if (value != num)
				{
					PoolElementData item = Elements[value];
					Elements.RemoveAt(value);
					Elements.Insert(num, item);
					DragTarget = num;
					_icons[num].transform.SetAsLastSibling();
				}
			}
		}

		private void UpdateDragIcon()
		{
			Vector2 normalizedMousePos = NormalizedMousePos;
			int num = Mathf.FloorToInt(normalizedMousePos.x);
			int num2 = Mathf.FloorToInt(normalizedMousePos.y);
			bool flag = false;
			bool flag2 = true;
			bool value = false;
			int num3 = 0;
			Vector2 point = default(Vector2);
			if (num >= 0 && num2 >= 0 && num < ItemsPerRow && num2 < UsedRows)
			{
				point = normalizedMousePos - new Vector2(num, num2);
				num3 = ItemsPerRow * num2 + num;
				flag = num3 <= Elements.Count;
				if (flag && !DragTarget.HasValue)
				{
					int count = Elements.Count;
					flag2 = num3 == count;
					value = num3 != count;
				}
			}
			_deleteIcon.gameObject.SetActive(value);
			_dragIcon.gameObject.SetActive(!flag2 && _dragRect.Contains(point));
			if (flag)
			{
				Vector3 position = _icons[num3].Position;
				_dragIcon.position = position;
				_deleteIcon.position = position;
			}
		}

		private void RemoveElement(int index)
		{
			Elements.RemoveAt(index);
		}

		private void UpdateLayout(bool instant)
		{
			EnsureCapacity();
			EnsureConsistency();
			UpdateIcons(instant);
			UpdateHeight(instant);
		}

		private void EnsureCapacity()
		{
			int count = Elements.Count;
			while (_icons.Count <= count)
			{
				_icons.Add(UnityEngine.Object.Instantiate(_iconTemplate, _iconTemplate.transform.parent));
			}
		}

		// Detects edits of the element list; new icons fly out of the "add" button and OnModified fires.
		private void EnsureConsistency()
		{
			int count = Elements.Count;
			int count2 = _prevElements.Count;
			if (count == count2)
			{
				bool flag = false;
				for (int i = 0; i < count; i++)
				{
					if (!_prevElements[i].Equals(Elements[i]))
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					return;
				}
			}
			else
			{
				ButtonAudioSource.PlayClick();
			}
			Vector3 vector = PositionAtIndex(count2);
			for (int j = 0; j < count; j++)
			{
				PoolElementIcon poolElementIcon = _icons[j];
				poolElementIcon.Position = (_prevPositions.TryGetValue(Elements[j], out var value) ? value : vector);
			}
			_prevPositions.Clear();
			_icons[count].transform.position = vector;
			_prevElements.Clear();
			_prevElements.AddRange(Elements);
			this.OnModified?.Invoke();
		}

		private void UpdateIcons(bool instant)
		{
			int count = Elements.Count;
			for (int i = 0; i < _icons.Count; i++)
			{
				PoolElementIcon poolElementIcon = _icons[i];
				if (i > count)
				{
					poolElementIcon.gameObject.SetActive(value: false);
					continue;
				}
				bool flag = DragTarget.HasValue && DragTarget.Value == i;
				float t = (instant ? 1f : (Time.deltaTime * _dragLerp));
				Vector3 b = (flag ? Input.mousePosition : PositionAtIndex(i));
				Vector3 vector = Vector3.Lerp(poolElementIcon.Position, b, t);
				poolElementIcon.Position = vector;
				poolElementIcon.gameObject.SetActive(value: true);
				if (i == count)
				{
					poolElementIcon.MarkAsAddButton();
					continue;
				}
				PoolElementData poolElementData = Elements[i];
				poolElementIcon.Data = poolElementData;
				_prevPositions[poolElementData] = vector;
			}
		}

		private void UpdateHeight(bool instant)
		{
			float t = (instant ? 1f : (Time.deltaTime * _heightLerp));
			float preferredHeight = _poolHeightRect.preferredHeight;
			float b = (float)UsedRows * _gridCellSize + _poolHeightPadding;
			if (!(Mathf.Abs(preferredHeight - b) < 0.05f))
			{
				float num = Mathf.Lerp(preferredHeight, b, t);
				RectTransform rectTransform = _poolHeightRect.transform as RectTransform;
				rectTransform.sizeDelta = new Vector2(rectTransform.sizeDelta.x, num);
				_poolHeightRect.preferredHeight = num;
			}
		}

		private bool TryGetHighlightedElement(out int index, out Vector2 relativePos, bool clamp = false)
		{
			index = 0;
			relativePos = default(Vector2);
			Vector2 normalizedMousePos = NormalizedMousePos;
			int num = Mathf.FloorToInt(normalizedMousePos.x);
			int num2 = Mathf.FloorToInt(normalizedMousePos.y);
			if (clamp)
			{
				num = Mathf.Clamp(num, 0, ItemsPerRow - 1);
				num2 = Mathf.Clamp(num2, 0, UsedRows - 1);
			}
			else if (num < 0 || num2 < 0 || num >= ItemsPerRow || num2 >= UsedRows)
			{
				return false;
			}
			index = ItemsPerRow * num2 + num;
			relativePos = new Vector2(normalizedMousePos.x - (float)num, normalizedMousePos.y - (float)num2);
			if (clamp)
			{
				index = Mathf.Clamp(index, 0, Elements.Count);
				return true;
			}
			return index <= Elements.Count;
		}

		private Vector3 PositionAtIndex(int index)
		{
			Rect rect = _poolRt.rect;
			Vector3 position = _poolRt.position;
			float scaleFactor = _canvas.scaleFactor;
			float num = scaleFactor * _gridCellSize;
			int itemsPerRow = ItemsPerRow;
			int num2 = index / itemsPerRow;
			int num3 = index % itemsPerRow;
			float x = rect.x * scaleFactor + position.x + num * 0.5f + (float)num3 * num;
			float y = (rect.height + rect.y) * scaleFactor + position.y - num * 0.5f + (float)(-num2) * num;
			return new Vector3(x, y, 0f);
		}
	}
}
