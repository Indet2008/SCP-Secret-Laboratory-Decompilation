using UnityEngine;
using UnityEngine.EventSystems;

namespace PlayerRoles.Spectating
{
	public class SpectatorGuiElement : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		private static SpectatorGuiElement _lastHighlight;

		public static bool AnyHighlighted { get; private set; }

		public void OnPointerEnter(PointerEventData eventData)
		{
			_lastHighlight = this;
			AnyHighlighted = true;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			if (!(_lastHighlight != this))
			{
				_lastHighlight = null;
				AnyHighlighted = false;
			}
		}

		private void OnDisable()
		{
			OnPointerExit(null);
		}

		private void OnDestroy()
		{
			OnPointerExit(null);
		}
	}
}
