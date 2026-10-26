namespace OperationalGuide
{
	public class OperationalPage : global::UnityEngine.MonoBehaviour
	{
		public global::UnityEngine.GameObject MainPage;

		public global::UnityEngine.GameObject DescriptionPage;

		public global::UnityEngine.UI.Image BackgroundImage;

		public bool F1PageActive;

		public global::UnityEngine.Animator PageAnimator;

		public virtual void ToggleDescriptionMenu()
		{
		}

		public virtual void TurnOn()
		{
		}

		public void ForceTurnOff()
		{
		}

		public virtual void OnPageEnable()
		{
		}

		public virtual void OnPageDisable()
		{
		}

		private void OnDisable()
		{
		}

		private void OnEnable()
		{
		}

		public OperationalPage()
		{
		}
	}
}
