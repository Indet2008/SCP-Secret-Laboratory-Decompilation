using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class OperationalPage : MonoBehaviour
	{
		public GameObject MainPage;

		public GameObject DescriptionPage;

		public Image BackgroundImage;

		public bool F1PageActive;

		public Animator PageAnimator;

		public virtual void ToggleDescriptionMenu()
		{
			if (!(DescriptionPage == null) && !(PageAnimator == null))
			{
				F1PageActive = !F1PageActive;
				PageAnimator.SetBool("main", F1PageActive);
			}
		}

		public virtual void TurnOn()
		{
			if (base.gameObject.activeSelf)
			{
				OperationalGuide.Instance.FadeAnimator.Play(Animator.StringToHash("Base Layer.PageFade"), -1, float.NegativeInfinity);
			}
			if (PageAnimator != null)
			{
				PageAnimator.SetBool("main", F1PageActive);
			}
			MainPage.SetActive(value: true);
			BackgroundImage.gameObject.SetActive(value: true);
			OperationalGuide.Instance.Back.SetActive(value: true);
		}

		public void ForceTurnOff()
		{
			MainPage.SetActive(value: false);
			BackgroundImage.gameObject.SetActive(value: false);
		}

		public virtual void OnPageEnable()
		{
		}

		public virtual void OnPageDisable()
		{
		}

		private void OnDisable()
		{
			OnPageDisable();
		}

		private void OnEnable()
		{
			OnPageEnable();
		}
	}
}
