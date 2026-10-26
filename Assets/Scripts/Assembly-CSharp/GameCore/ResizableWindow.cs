using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace GameCore
{
	public class ResizableWindow : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler
	{
		private enum ResizeDirection
		{
			None = 0,
			Left = 1,
			Right = 2,
			Top = 3,
			Bottom = 4
		}

		[SerializeField]
		private float _scaleSpeed = 20f;

		[SerializeField]
		private RectTransform _panelRectTransform;

		[SerializeField]
		private float _edgeDetectSize = 15f;

		[SerializeField]
		private Vector2 _minSize = new Vector2(100f, 100f);

		[SerializeField]
		private Vector2 _maxSize = new Vector2(400f, 400f);

		private ResizeDirection _resizeDirection;

		private Vector2 _originalLocalPointerPosition;

		private Vector2 _originalSizeDelta;

		private Vector2 _originalAnchoredPosition;

		private Vector2 _targetSize;

		private Vector2 _targetAnchoredPosition;

		private bool _isResizing;

		private bool _isHovering;

		public Vector2 CurrentSize => _panelRectTransform.sizeDelta;

		public event Action<Vector2> OnResizingEnded;

		public void SetScaleAndResetPosition(Vector2 scale)
		{
			scale.x = Mathf.Clamp(scale.x, _minSize.x, _maxSize.x);
			scale.y = Mathf.Clamp(scale.y, _minSize.y, _maxSize.y);
			_targetSize = scale;
		}

		public void OnDrag(PointerEventData eventData)
		{
			if (_resizeDirection != ResizeDirection.None)
			{
				RectTransformUtility.ScreenPointToLocalPointInRectangle(_panelRectTransform.parent as RectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
				Vector2 originalSizeDelta = _originalSizeDelta;
				Vector2 originalAnchoredPosition = _originalAnchoredPosition;
				switch (_resizeDirection)
				{
				case ResizeDirection.Left:
				{
					float num4 = _originalAnchoredPosition.x + _originalSizeDelta.x * 0.5f;
					originalAnchoredPosition.x = num4 - (originalSizeDelta.x = Mathf.Clamp(num4 - localPoint.x, _minSize.x, _maxSize.x)) * 0.5f;
					break;
				}
				case ResizeDirection.Right:
				{
					float num3 = _originalAnchoredPosition.x - _originalSizeDelta.x * 0.5f;
					originalAnchoredPosition.x = num3 + (originalSizeDelta.x = Mathf.Clamp(localPoint.x - num3, _minSize.x, _maxSize.x)) * 0.5f;
					break;
				}
				case ResizeDirection.Top:
				{
					float num2 = _originalAnchoredPosition.y - _originalSizeDelta.y * 0.5f;
					originalAnchoredPosition.y = num2 + (originalSizeDelta.y = Mathf.Clamp(localPoint.y - num2, _minSize.y, _maxSize.y)) * 0.5f;
					break;
				}
				case ResizeDirection.Bottom:
				{
					float num = _originalAnchoredPosition.y + _originalSizeDelta.y * 0.5f;
					originalAnchoredPosition.y = num - (originalSizeDelta.y = Mathf.Clamp(num - localPoint.y, _minSize.y, _maxSize.y)) * 0.5f;
					break;
				}
				}
				_targetSize = originalSizeDelta;
				_targetAnchoredPosition = originalAnchoredPosition;
			}
		}

		public void OnBeginDrag(PointerEventData eventData)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(_panelRectTransform, eventData.position, eventData.pressEventCamera, out _originalLocalPointerPosition);
			_originalSizeDelta = _panelRectTransform.sizeDelta;
			_originalAnchoredPosition = _panelRectTransform.anchoredPosition;
			_resizeDirection = DetectResizeDirection(_originalLocalPointerPosition);
			WindowsCursorApi.SetCursor(GetCursorFromDirection(_resizeDirection));
			if (_resizeDirection != ResizeDirection.None)
			{
				_isResizing = true;
			}
		}

		private void Update()
		{
			_panelRectTransform.anchoredPosition = Vector2.Lerp(_panelRectTransform.anchoredPosition, _targetAnchoredPosition, Time.deltaTime * _scaleSpeed);
			_panelRectTransform.sizeDelta = Vector2.Lerp(_panelRectTransform.sizeDelta, _targetSize, Time.deltaTime * _scaleSpeed);
			EdgeHoverDetection();
		}

		private void EdgeHoverDetection()
		{
			if (!_isResizing)
			{
				RectTransformUtility.ScreenPointToLocalPointInRectangle(_panelRectTransform, Input.mousePosition, null, out var localPoint);
				ResizeDirection resizeDirection = DetectResizeDirection(localPoint);
				if (!_isHovering && resizeDirection != ResizeDirection.None)
				{
					_isHovering = true;
					WindowsCursorApi.SetCursor(GetCursorFromDirection(resizeDirection));
				}
				else if (_isHovering && resizeDirection == ResizeDirection.None)
				{
					_isHovering = false;
					WindowsCursorApi.SetCursor(SystemCursorID.Default);
				}
			}
		}

		private void OnDisable()
		{
			HandleEnd();
		}

		public void OnEndDrag(PointerEventData eventData)
		{
			HandleEnd();
		}

		private void HandleEnd()
		{
			if (_isResizing)
			{
				OnResizingEnded?.Invoke(_targetSize);
			}
			if (_isResizing || _isHovering)
			{
				_isResizing = false;
				_isHovering = false;
				WindowsCursorApi.SetCursor(SystemCursorID.Default);
			}
		}

		private ResizeDirection DetectResizeDirection(Vector2 localPointer)
		{
			Rect rect = _panelRectTransform.rect;
			if (Mathf.Abs(localPointer.x - rect.xMin) <= _edgeDetectSize)
			{
				return ResizeDirection.Left;
			}
			if (Mathf.Abs(localPointer.x - rect.xMax) <= _edgeDetectSize)
			{
				return ResizeDirection.Right;
			}
			if (Mathf.Abs(localPointer.y - rect.yMax) <= _edgeDetectSize)
			{
				return ResizeDirection.Top;
			}
			if (Mathf.Abs(localPointer.y - rect.yMin) <= _edgeDetectSize)
			{
				return ResizeDirection.Bottom;
			}
			return ResizeDirection.None;
		}

		private SystemCursorID GetCursorFromDirection(ResizeDirection direction)
		{
			switch (direction)
			{
			case ResizeDirection.Left:
			case ResizeDirection.Right:
				return SystemCursorID.SizeHorizontal;
			case ResizeDirection.Top:
			case ResizeDirection.Bottom:
				return SystemCursorID.SizeVertical;
			default:
				return SystemCursorID.Default;
			}
		}
	}
}
