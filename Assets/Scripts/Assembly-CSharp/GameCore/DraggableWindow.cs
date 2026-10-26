using UnityEngine;
using UnityEngine.EventSystems;

namespace GameCore
{
	public class DraggableWindow : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler
	{
		[SerializeField]
		private RectTransform _dragWindow;

		[SerializeField]
		private Canvas _targetCanvas;

		[SerializeField]
		private float _movementSpeed = 25f;

		[SerializeField]
		private Vector2 _verticalClamp;

		[SerializeField]
		private Vector2 _horizontalClamp;

		private Vector2 _targetPosition;

		private bool _isDragging;

		public void OnBeginDrag(PointerEventData eventData)
		{
			WindowsCursorApi.SetCursor(SystemCursorID.SizeAll);
			_isDragging = true;
		}

		public void OnDrag(PointerEventData eventData)
		{
			_targetPosition += eventData.delta / _targetCanvas.scaleFactor;
		}

		public void OnEndDrag(PointerEventData eventData)
		{
			HandleEnd();
		}

		private void Start()
		{
			_targetPosition = _dragWindow.anchoredPosition;
		}

		private void Update()
		{
			Vector2 anchoredPosition = Vector2.Lerp(_dragWindow.anchoredPosition, _targetPosition, Time.deltaTime * _movementSpeed);
			anchoredPosition.x = Mathf.Clamp(anchoredPosition.x, _horizontalClamp.x, _horizontalClamp.y);
			anchoredPosition.y = Mathf.Clamp(anchoredPosition.y, _verticalClamp.x, _verticalClamp.y);
			_dragWindow.anchoredPosition = anchoredPosition;
		}

		private void OnDisable()
		{
			HandleEnd();
		}

		private void HandleEnd()
		{
			if (_isDragging)
			{
				_isDragging = false;
				WindowsCursorApi.SetCursor(SystemCursorID.Default);
			}
		}
	}
}
