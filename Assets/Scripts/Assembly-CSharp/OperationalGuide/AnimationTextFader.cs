namespace OperationalGuide
{
	public class AnimationTextFader : global::UnityEngine.MonoBehaviour, global::UnityEngine.EventSystems.IPointerEnterHandler, global::UnityEngine.EventSystems.IEventSystemHandler, global::UnityEngine.EventSystems.IPointerExitHandler
	{
		private static readonly int FadeAnimationID;

		private const string FadeAnimKey = "fade";

		public global::UnityEngine.Animator Animator;

		public void OnPointerEnter(global::UnityEngine.EventSystems.PointerEventData eventData)
		{
		}

		public void OnPointerExit(global::UnityEngine.EventSystems.PointerEventData eventData)
		{
		}

		private void OnDisable()
		{
		}

		private void OnEnable()
		{
		}

		public AnimationTextFader()
		{
		}
	}
}
