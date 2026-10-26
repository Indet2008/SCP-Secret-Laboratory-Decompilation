using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Tooltips
{
	// Client-only in v14 (the server build ships a signature-only shell). Shows the stored tip of whatever
	// UI element is under the cursor after ShowDelay, and hides it HideDelay after the cursor leaves.
	public class TooltipManager : MonoBehaviour
	{
		[SerializeField]
		private Tooltip _tooltip;

		private float _showTimer;

		private float _hideTimer;

		private PointerEventData _pointerData;

		private EventSystem _pointerEventSystem;

		private readonly List<RaycastResult> _raycastResults = new List<RaycastResult>();

		private string _hoveredText;

		public Dictionary<GameObject, string> StoredTips { get; } = new Dictionary<GameObject, string>();

		public bool IsEnabled { get; set; } = true;

		public bool IsVisible { get; private set; }

		public Tooltip Tooltip => _tooltip;

		[field: SerializeField]
		public float ShowDelay { get; set; }

		[field: SerializeField]
		public float HideDelay { get; set; }

		[field: SerializeField]
		public bool MoveToMousePosition { get; set; }

		private float HideTimer
		{
			get
			{
				return _hideTimer;
			}
			set
			{
				_hideTimer = Mathf.Max(0f, value);
			}
		}

		private float ShowTimer
		{
			get
			{
				return _showTimer;
			}
			set
			{
				_showTimer = Mathf.Max(0f, value);
			}
		}

		private void Start()
		{
			// Tip holders may sit on inactive tabs whose Awake has not run yet.
			foreach (CustomTooltipData customTooltipData in Object.FindObjectsByType<CustomTooltipData>(FindObjectsInactive.Include, FindObjectsSortMode.None))
			{
				if (customTooltipData.Manager != this || customTooltipData.StoredInfo == null)
				{
					continue;
				}
				foreach (TooltipData tooltipData in customTooltipData.StoredInfo)
				{
					if (tooltipData.Key != null)
					{
						StoredTips[tooltipData.Key] = tooltipData.Text;
					}
				}
			}
			if (_tooltip != null)
			{
				_tooltip.gameObject.SetActive(false);
			}
		}

		private void Update()
		{
			if (_tooltip == null)
			{
				return;
			}
			if (!IsEnabled)
			{
				ShowTimer = 0f;
				SetState(isVisible: false);
				return;
			}
			bool flag = false;
			if (IsCursorOverUI(out var result))
			{
				Transform transform = result.gameObject.transform;
				while (transform != null)
				{
					if (StoredTips.TryGetValue(transform.gameObject, out var value))
					{
						_hoveredText = value;
						flag = true;
						break;
					}
					transform = transform.parent;
				}
			}
			TickState(flag);
			if (IsVisible && MoveToMousePosition)
			{
				_tooltip.SetPosition(Input.mousePosition);
			}
		}

		private void SetState(bool isVisible)
		{
			if (IsVisible == isVisible && _tooltip.gameObject.activeSelf == isVisible)
			{
				return;
			}
			IsVisible = isVisible;
			if (isVisible)
			{
				_tooltip.SetText(_hoveredText);
				_tooltip.SetPosition(Input.mousePosition);
			}
			_tooltip.gameObject.SetActive(isVisible);
		}

		private void TickState(bool isHoveringElement)
		{
			if (isHoveringElement)
			{
				HideTimer = HideDelay;
				if (IsVisible)
				{
					_tooltip.SetText(_hoveredText);
					return;
				}
				ShowTimer += Time.unscaledDeltaTime;
				if (ShowTimer >= ShowDelay)
				{
					SetState(isVisible: true);
				}
				return;
			}
			ShowTimer = 0f;
			if (IsVisible)
			{
				HideTimer -= Time.unscaledDeltaTime;
				if (HideTimer <= 0f)
				{
					SetState(isVisible: false);
				}
			}
			else if (_tooltip.gameObject.activeSelf)
			{
				_tooltip.gameObject.SetActive(false);
			}
		}

		private bool IsCursorOverUI(out RaycastResult result)
		{
			result = default(RaycastResult);
			EventSystem current = EventSystem.current;
			if (current == null)
			{
				return false;
			}
			if (_pointerData == null || _pointerEventSystem != current)
			{
				_pointerData = new PointerEventData(current);
				_pointerEventSystem = current;
			}
			_pointerData.position = Input.mousePosition;
			_raycastResults.Clear();
			current.RaycastAll(_pointerData, _raycastResults);
			foreach (RaycastResult raycastResult in _raycastResults)
			{
				if (raycastResult.gameObject != null && !raycastResult.gameObject.transform.IsChildOf(_tooltip.transform))
				{
					result = raycastResult;
					return true;
				}
			}
			return false;
		}
	}
}
