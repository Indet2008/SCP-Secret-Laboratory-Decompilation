using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UserSettings;
using UserSettings.UserInterfaceSettings;

// Rewritten: this client-only script had no source in the server build (it is not in the SL 12 Community Edition either).
// The warning stays up until any key/click, unless the player ticked "Do not show again".
public class PhotosensitivityWarning : MonoBehaviour
{
	private enum Photosensitivity
	{
		FirstViewing = 0
	}

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::TMPro.TextMeshProUGUI _skipText;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.UI.Image _loadingBar;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.UI.Toggle _showToggle;

	[global::UnityEngine.SerializeField]
	private float _lerpModifier;

	[global::UnityEngine.SerializeField]
	private float _timeOffset;

	[global::UnityEngine.SerializeField]
	private bool _reset;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.GameObject _parentObject;


	private const float InputDelay = 0.5f;

	private Toggle _doNotShowToggle;

	private float _shownTime;

	private void Start()
	{
		if (UserSetting<bool>.Get(UISetting.PhotosensitivityDoNotShow))
		{
			gameObject.SetActive(false);
			return;
		}
		_doNotShowToggle = GetComponentInChildren<Toggle>(includeInactive: true);
		if (_doNotShowToggle != null)
		{
			_doNotShowToggle.SetIsOnWithoutNotify(false);
		}
		_shownTime = Time.unscaledTime;
	}

	private void Update()
	{
		if (Time.unscaledTime - _shownTime < InputDelay || !Input.anyKeyDown)
		{
			return;
		}
		// Clicking the "Do not show again" toggle must not also dismiss the warning.
		if (_doNotShowToggle != null && EventSystem.current != null && EventSystem.current.currentSelectedGameObject == _doNotShowToggle.gameObject && Input.GetMouseButtonDown(0))
		{
			return;
		}
		gameObject.SetActive(false);
	}

	public void Toggled()
	{
		if (_doNotShowToggle != null)
		{
			UserSetting<bool>.Set(UISetting.PhotosensitivityDoNotShow, _doNotShowToggle.isOn);
		}
	}
}
