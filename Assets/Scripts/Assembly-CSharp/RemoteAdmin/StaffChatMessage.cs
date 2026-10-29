using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class StaffChatMessage : MonoBehaviour
	{
		[SerializeField]
		private Image _image;

		[SerializeField]
		private TextMeshProUGUI _text;

		public Color Color
		{
			get
			{
				return _image.color;
			}
			set
			{
				_image.color = value;
			}
		}

		public string Content
		{
			get
			{
				return _text.text;
			}
			set
			{
				_text.text = value;
			}
		}
	}
}
