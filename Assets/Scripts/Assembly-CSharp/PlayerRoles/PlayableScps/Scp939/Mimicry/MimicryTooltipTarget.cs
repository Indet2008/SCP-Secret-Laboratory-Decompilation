using UnityEngine;
using UnityEngine.EventSystems;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryTooltipTarget : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler
	{
		[SerializeField]
		private Scp939HudTranslation _targetHint;

		private static MimicryTooltipTarget _curTarget;

		public void OnPointerEnter(PointerEventData eventData)
		{
			_curTarget = this;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			Deselect();
		}

		public void OnPointerDown(PointerEventData eventData)
		{
			Deselect();
		}

		private void OnDisable()
		{
			Deselect();
		}

		private void Deselect()
		{
			if (!(_curTarget != this))
			{
				_curTarget = null;
			}
		}

		internal static bool TryGetHint(out Scp939HudTranslation hint)
		{
			if (_curTarget == null)
			{
				hint = Scp939HudTranslation.PressKeyToLunge;
				return false;
			}
			hint = _curTarget._targetHint;
			return true;
		}
	}
}
