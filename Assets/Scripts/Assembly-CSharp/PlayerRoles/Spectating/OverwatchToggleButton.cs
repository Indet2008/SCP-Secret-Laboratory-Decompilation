using TMPro;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchToggleButton : MonoBehaviour
	{
		public static readonly Color EnabledColor = new Color32(153, byte.MaxValue, 150, byte.MaxValue);

		public static readonly Color DisabledColor = new Color32(byte.MaxValue, 67, 54, byte.MaxValue);

		[Tooltip("The icon of the button, used to handle its color.")]
		public TextMeshProUGUI Icon;

		private bool _isToggled = true;

		public bool IsToggled
		{
			get
			{
				return _isToggled;
			}
			set
			{
				_isToggled = value;
				UpdateColor();
			}
		}

		public void Toggle()
		{
			IsToggled = !IsToggled;
		}

		private void UpdateColor()
		{
			if (_isToggled)
			{
				Icon.color = EnabledColor;
			}
			else
			{
				Icon.color = DisabledColor;
			}
		}
	}
}
