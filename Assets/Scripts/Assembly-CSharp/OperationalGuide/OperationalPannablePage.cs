namespace OperationalGuide
{
	public class OperationalPannablePage : global::OperationalGuide.OperationalPage
	{
		public global::OperationalGuide.PannableObject PannableObject;

		public global::UnityEngine.GameObject PannableImage;

		private global::UnityEngine.Vector3 _defaultScale;

		private global::UnityEngine.Quaternion _defaultRotation;

		public override void OnPageEnable()
		{
		}

		public override void OnPageDisable()
		{
		}

		public void ResetUserInput()
		{
		}

		public virtual void SpawnPannable()
		{
		}

		public OperationalPannablePage()
		{
		}
	}
}
