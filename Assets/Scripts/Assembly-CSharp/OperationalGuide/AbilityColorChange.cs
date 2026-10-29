using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class AbilityColorChange : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		public GameObject ChildTextParent;

		public Image AbilityIcon;

		public Color SelectedColor;

		public Color DefaultColor;

		public void OnPointerEnter(PointerEventData eventData)
		{
			AbilityIcon.color = SelectedColor;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			if (!ChildTextParent.activeInHierarchy)
			{
				AbilityIcon.color = DefaultColor;
			}
		}
	}
}
