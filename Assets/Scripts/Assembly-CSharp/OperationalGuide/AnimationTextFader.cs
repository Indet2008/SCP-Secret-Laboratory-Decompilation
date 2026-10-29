using UnityEngine;
using UnityEngine.EventSystems;

namespace OperationalGuide
{
	public class AnimationTextFader : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		private static readonly int FadeAnimationID = Animator.StringToHash("fade");

		private const string FadeAnimKey = "fade";

		public Animator Animator;

		public void OnPointerEnter(PointerEventData eventData)
		{
			Animator.SetBool(FadeAnimationID, value: true);
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			Animator.SetBool(FadeAnimationID, value: false);
		}

		private void OnDisable()
		{
			Animator.SetBool(FadeAnimationID, value: false);
		}

		private void OnEnable()
		{
			Animator.SetBool(FadeAnimationID, value: false);
		}
	}
}
