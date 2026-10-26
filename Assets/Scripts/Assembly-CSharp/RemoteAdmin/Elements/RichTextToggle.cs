using RemoteAdmin.Presets;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Elements
{
	public class RichTextToggle : CustomButton
	{
		[SerializeField]
		private Button _button;

		[SerializeField]
		private ToggleColorPreset _colorPreset;

		[SerializeField]
		private string _configKey;

		public override void SetState(bool isSelected)
		{
			base.SetState(isSelected);
			if (base.Text != null)
			{
				base.Text.richText = isSelected;
			}
			if (_button != null && _colorPreset != null)
			{
				_button.colors = (isSelected ? _colorPreset.Selected : _colorPreset.Unselected);
			}
			if (!string.IsNullOrEmpty(_configKey))
			{
				PlayerPrefsSl.Set(_configKey, isSelected);
			}
		}

		public void Toggle()
		{
			SetState(!base.IsSelected);
		}

		private void Start()
		{
			if (!string.IsNullOrEmpty(_configKey))
			{
				SetState(PlayerPrefsSl.Get(_configKey, defaultValue: true));
			}
		}
	}
}