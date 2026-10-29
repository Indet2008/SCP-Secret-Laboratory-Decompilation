using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class PageButton : MonoBehaviour
	{
		public Button Button;

		public Image Image;

		[SerializeField]
		private RectTransform _buttonRectTransform;

		public float ButtonWidth => _buttonRectTransform.rect.width;
	}
}
