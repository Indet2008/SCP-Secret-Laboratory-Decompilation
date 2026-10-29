using UnityEngine;
using UnityEngine.EventSystems;

namespace OperationalGuide
{
	public class FullscreenPannableButton : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
	{
		public void OnPointerClick(PointerEventData eventData)
		{
			OperationalGuide.Instance.SetFullscreen(state: true);
		}
	}
}
