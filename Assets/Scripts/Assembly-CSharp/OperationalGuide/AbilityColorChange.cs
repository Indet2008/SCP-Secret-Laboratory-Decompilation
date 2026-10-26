namespace OperationalGuide
{
	public class AbilityColorChange : global::UnityEngine.MonoBehaviour, global::UnityEngine.EventSystems.IPointerEnterHandler, global::UnityEngine.EventSystems.IEventSystemHandler, global::UnityEngine.EventSystems.IPointerExitHandler
	{
		public global::UnityEngine.GameObject ChildTextParent;

		public global::UnityEngine.UI.Image AbilityIcon;

		public global::UnityEngine.Color SelectedColor;

		public global::UnityEngine.Color DefaultColor;

		public void OnPointerEnter(global::UnityEngine.EventSystems.PointerEventData eventData)
		{
		}

		public void OnPointerExit(global::UnityEngine.EventSystems.PointerEventData eventData)
		{
		}

		public AbilityColorChange()
		{
		}
	}
}
