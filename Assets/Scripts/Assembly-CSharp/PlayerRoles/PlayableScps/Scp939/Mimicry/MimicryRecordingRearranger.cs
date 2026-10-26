using UnityEngine;
using UnityEngine.EventSystems;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryRecordingRearranger : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
	{
		[SerializeField]
		private MimicryRecordingsMenu _menu;

		[SerializeField]
		private MimicryRecordingIcon _icon;

		public void OnPointerDown(PointerEventData eventData)
		{
			if (eventData.button == PointerEventData.InputButton.Left)
			{
				_menu.BeginDrag(_icon);
			}
		}
	}
}
