using TMPro;
using UnityEngine;

namespace RemoteAdmin.Elements
{
	public class RaEffectButton : SendButton
	{
		private const string DefaultIntensity = "1";

		private const string DefaultDuration = "0";

		private const string ClearValue = "0";

		[SerializeField]
		private TMP_InputField _durationField;

		[SerializeField]
		private TMP_InputField _intensityField;

		[SerializeField]
		private SendButton _clearButton;

		public string EffectId { get; set; }

		public string EffectName { get; set; }

		public string Duration
		{
			get
			{
				if (!(_durationField == null) && !string.IsNullOrEmpty(_durationField.text))
				{
					return _durationField.text;
				}
				return DefaultDuration;
			}
		}

		public string Intensity
		{
			get
			{
				if (!(_intensityField == null) && !string.IsNullOrEmpty(_intensityField.text))
				{
					return _intensityField.text;
				}
				return DefaultIntensity;
			}
		}

		public void Setup()
		{
			EnsureInitialized();
			if (base.Text != null)
			{
				base.Text.text = EffectName;
			}
			if (_clearButton != null)
			{
				_clearButton.CustomCommand = CustomCommand + " " + EffectId + " " + ClearValue + " " + ClearValue;
				_clearButton.CommandMenu = base.CommandMenu;
			}
		}

		public void ResetFields()
		{
			if (_durationField != null)
			{
				_durationField.text = string.Empty;
			}
			if (_intensityField != null)
			{
				_intensityField.text = string.Empty;
			}
		}

		protected override void SendCommand(string command, string format)
		{
			base.SendCommand(command + " " + EffectId + " " + Intensity + " " + Duration, format);
		}
	}
}