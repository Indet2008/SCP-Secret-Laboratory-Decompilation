using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UserSettings;
using UserSettings.UserInterfaceSettings;

public class PhotosensitivityWarning : MonoBehaviour
{
	private enum Photosensitivity
	{
		FirstViewing = 0
	}

	private float _currentViewingTime;

	private float _intendedViewingTime;

	[SerializeField]
	private TextMeshProUGUI _skipText;

	[SerializeField]
	private Image _loadingBar;

	[SerializeField]
	private Toggle _showToggle;

	[SerializeField]
	private float _lerpModifier;

	[SerializeField]
	private float _timeOffset;

	[SerializeField]
	private bool _reset;

	[SerializeField]
	private GameObject _parentObject;

	private void Start()
	{
		if (UserSetting<bool>.Get(UISetting.PhotosensitivityDoNotShow, defaultValue: false, setAsDefault: true))
		{
			_parentObject.SetActive(false);
			return;
		}
		_parentObject.SetActive(true);
		_intendedViewingTime = (UserSetting<bool>.Get(Photosensitivity.FirstViewing, defaultValue: false, setAsDefault: true) ? 0f : 5f);
	}

	private void Update()
	{
		if (_reset)
		{
			_currentViewingTime = 0f;
			_skipText.alpha = 0f;
			_intendedViewingTime = (UserSetting<bool>.Get(Photosensitivity.FirstViewing, defaultValue: false, setAsDefault: true) ? 0f : 5f);
			_reset = false;
		}
		_currentViewingTime += Time.deltaTime;
		_loadingBar.fillAmount = 1f - _currentViewingTime / _intendedViewingTime;
		if (_currentViewingTime >= _intendedViewingTime - _timeOffset)
		{
			_skipText.alpha = Mathf.Lerp(_skipText.alpha, 1f, Time.deltaTime * _lerpModifier);
		}
		if (Input.anyKey && !Input.GetMouseButton(0) && !Input.GetMouseButton(1) && !Input.GetMouseButton(2))
		{
			Skip();
		}
	}

	public void Skip()
	{
		if (!(_intendedViewingTime > _currentViewingTime))
		{
			UserSetting<bool>.Set(Photosensitivity.FirstViewing, value: true);
			_parentObject.SetActive(false);
		}
	}

	public void Toggled()
	{
		UserSetting<bool>.Set(UISetting.PhotosensitivityDoNotShow, _showToggle.isOn);
	}
}
