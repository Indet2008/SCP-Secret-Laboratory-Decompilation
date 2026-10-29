using UnityEngine;

namespace OperationalGuide
{
	public class OperationalPannablePage : OperationalPage
	{
		public PannableObject PannableObject;

		public GameObject PannableImage;

		private Vector3 _defaultScale;

		private Quaternion _defaultRotation;

		public override void OnPageEnable()
		{
			if (PannableObject == null)
			{
				SpawnPannable();
			}
			_defaultScale = PannableImage.transform.localScale;
			_defaultRotation = PannableObject.transform.rotation;
			PannableObject.gameObject.SetActive(value: true);
			Transform transform = OperationalGuide.Instance.FullscreenPannableImage.transform;
			transform.localScale = Vector3.one;
			transform.localPosition = Vector3.zero;
		}

		public override void OnPageDisable()
		{
			PannableImage.transform.localScale = _defaultScale;
			PannableObject.transform.rotation = _defaultRotation;
			PannableObject.gameObject.SetActive(value: false);
		}

		public void ResetUserInput()
		{
			PannableObject.UserInput = false;
		}

		public virtual void SpawnPannable()
		{
		}
	}
}
