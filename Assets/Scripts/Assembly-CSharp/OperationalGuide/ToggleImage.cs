using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class ToggleImage : MonoBehaviour
	{
		private bool _toggled;

		[SerializeField]
		private Sprite _defaultSprite;

		[SerializeField]
		private Sprite _toggledSprite;

		[SerializeField]
		private Image _sourceImage;

		public void ButtonToggleImage()
		{
			_toggled = !_toggled;
			_sourceImage.sprite = (_toggled ? _toggledSprite : _defaultSprite);
		}
	}
}
