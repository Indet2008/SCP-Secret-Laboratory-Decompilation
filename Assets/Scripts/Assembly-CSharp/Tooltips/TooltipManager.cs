namespace Tooltips
{
	public class TooltipManager : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.SerializeField]
		private global::Tooltips.Tooltip _tooltip;

		private float _showTimer;

		private float _hideTimer;

		private global::UnityEngine.EventSystems.PointerEventData _pointerData;

		public global::System.Collections.Generic.Dictionary<global::UnityEngine.GameObject, string> StoredTips
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
		}

		public bool IsEnabled
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		public bool IsVisible
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public global::Tooltips.Tooltip Tooltip
		{
			get
			{
				return default;
			}
		}

		public float ShowDelay
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		public float HideDelay
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		public bool MoveToMousePosition
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		private float HideTimer
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		private float ShowTimer
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		private void Update()
		{
		}

		private void SetState(bool isVisible)
		{
		}

		private void TickState(bool isHoveringElement)
		{
		}

		private bool IsCursorOverUI(out global::UnityEngine.EventSystems.RaycastResult result)
		{ result = default;
			return default;
		}

		public TooltipManager()
		{
		}
	}
}
