using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class OpacityDistance : MonoBehaviour
	{
		public Image[] Images;

		public TextMeshProUGUI[] Text;

		public float DistanceDivider = 350f;

		private bool _toggled;

		// Elements fade out with cursor distance unless toggled to stay fully visible.
		private void Update()
		{
			if (_toggled)
			{
				return;
			}
			Image[] images = Images;
			foreach (Image image in images)
			{
				Color color = image.color;
				float num = Mathf.Abs(Vector3.Distance(Input.mousePosition, image.transform.position)) / DistanceDivider;
				image.color = new Color(color.r, color.g, color.b, 1f - num);
			}
			TextMeshProUGUI[] text = Text;
			foreach (TextMeshProUGUI textMeshProUGUI in text)
			{
				Color color2 = textMeshProUGUI.color;
				float num2 = Mathf.Abs(Vector3.Distance(Input.mousePosition, textMeshProUGUI.transform.position)) / DistanceDivider;
				textMeshProUGUI.color = new Color(color2.r, color2.g, color2.b, 1f - num2);
			}
		}

		public void Toggle()
		{
			bool toggled = _toggled;
			_toggled = !_toggled;
			if (!toggled)
			{
				Image[] images = Images;
				foreach (Image image in images)
				{
					Color color = image.color;
					image.color = new Color(color.r, color.g, color.b, 1f);
				}
				TextMeshProUGUI[] text = Text;
				foreach (TextMeshProUGUI textMeshProUGUI in text)
				{
					Color color2 = textMeshProUGUI.color;
					textMeshProUGUI.color = new Color(color2.r, color2.g, color2.b, 1f);
				}
			}
		}
	}
}
