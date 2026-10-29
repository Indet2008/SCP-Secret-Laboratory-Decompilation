using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class ButtonColorTilt : MonoBehaviour
	{
		public Color DefaultColor;

		public Color SelectedColor;

		public TextMeshProUGUI Text;

		public Image Image;

		public void PointerEnter()
		{
			Text.color = SelectedColor;
			Image.color = SelectedColor;
		}

		public void PointerExit()
		{
			Text.color = DefaultColor;
			Image.color = DefaultColor;
		}
	}
}
