namespace OperationalGuide
{
	public class ToggleImage : global::UnityEngine.MonoBehaviour
	{
		private bool _toggled;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Sprite _defaultSprite;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Sprite _toggledSprite;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _sourceImage;

		public void ButtonToggleImage()
		{
		}

		public ToggleImage()
		{
		}
	}
}
