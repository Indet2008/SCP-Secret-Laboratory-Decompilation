using TMPro;
using UnityEngine;

namespace UserSettings.GUIElements
{
	public class UserSettingsDescriptionText : MonoBehaviour
	{
		private TMP_Text _text;

		private UserSettingsEntryDescription _prev;

		[SerializeField]
		private float _transitionSpeed;

		private UserSettingsEntryDescription Current => UserSettingsEntryDescription.CurrentDescription;

		private void Awake()
		{
			_text = GetComponent<TMP_Text>();
		}

		private void OnEnable()
		{
			_text.alpha = 0f;
		}

		private void Update()
		{
			if (_prev == Current)
			{
				UpdateCurrent();
			}
			else
			{
				DisablePrevious();
			}
		}

		private void DisablePrevious()
		{
			if (_text.alpha > 0f)
			{
				_text.alpha -= _transitionSpeed * Time.deltaTime;
			}
			else
			{
				_prev = UserSettingsEntryDescription.CurrentDescription;
			}
		}

		private void UpdateCurrent()
		{
			if (Current == null)
			{
				_text.alpha = 0f;
				return;
			}
			_text.text = Current.Text;
			_text.alpha = Mathf.MoveTowards(_text.alpha, 1f, Time.deltaTime * _transitionSpeed);
		}
	}
}
