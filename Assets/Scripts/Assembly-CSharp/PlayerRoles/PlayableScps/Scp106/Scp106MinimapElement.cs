using MapGeneration;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106MinimapElement : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		[field: SerializeField]
		public Image Img { get; private set; }

		[field: SerializeField]
		public RectTransform Rt { get; private set; }

		public RoomIdentifier Room { get; internal set; }

		public static bool AnyHighlighted { get; private set; }

		public static Scp106MinimapElement LastHighlighted { get; private set; }

		public void OnPointerEnter(PointerEventData eventData)
		{
			LastHighlighted = this;
			AnyHighlighted = true;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			if (!(LastHighlighted != this))
			{
				LastHighlighted = null;
				AnyHighlighted = false;
			}
		}
	}
}
