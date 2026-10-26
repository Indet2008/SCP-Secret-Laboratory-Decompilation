using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.UserInterfaceSettings
{
	public class PasswordInputField : MonoBehaviour
	{
		private TMP_InputField _inputField;

		[SerializeField]
		private Toggle _toggleVisibility;

		[SerializeField]
		private TMP_InputField.ContentType _falseType;

		[SerializeField]
		private TMP_InputField.ContentType _trueType;

		private bool _prevValue;

		private void Awake()
		{
			_inputField = GetComponent<TMP_InputField>();
			_prevValue = !_toggleVisibility.isOn;
		}

		private void Update()
		{
			bool isOn = _toggleVisibility.isOn;
			if (_prevValue != isOn)
			{
				_inputField.contentType = (isOn ? _trueType : _falseType);
				_inputField.ForceLabelUpdate();
				_prevValue = isOn;
			}
		}
	}
}
