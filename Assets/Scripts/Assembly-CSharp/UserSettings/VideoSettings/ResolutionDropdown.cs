using System;
using TMPro;
using UnityEngine;

namespace UserSettings.VideoSettings
{
	public class ResolutionDropdown : MonoBehaviour
	{
		[SerializeField]
		private TextLanguageReplacer _noResolutionsErrorMessage;

		[SerializeField]
		private TMP_Text _unsupportedRatioText;

		private TMP_Dropdown _dropdown;

		private void Awake()
		{
			_dropdown = GetComponent<TMP_Dropdown>();
			UpdateValues();
			DisplayVideoSettings.OnDisplayChanged += UpdateValues;
			UserSetting<int>.AddListener(DisplayVideoSetting.AspectRatio, OnAspectRatioChanged);
		}

		private void OnDestroy()
		{
			DisplayVideoSettings.OnDisplayChanged -= UpdateValues;
			UserSetting<int>.RemoveListener(DisplayVideoSetting.AspectRatio, OnAspectRatioChanged);
		}

		private void Update()
		{
			Resolution res = new Resolution
			{
				width = Screen.width,
				height = Screen.height
			};
			if (_unsupportedRatioText == null)
			{
				return;
			}
			_unsupportedRatioText.enabled =!DisplayVideoSettings.IsSupportedRatio(res);
		}

		private void UpdateValues()
		{
			OnAspectRatioChanged(UserSetting<int>.Get(DisplayVideoSetting.AspectRatio));
		}

		private void OnAspectRatioChanged(int selectedOption)
		{
			_dropdown.ClearOptions();
			bool flag = false;
			Resolution[] selectedAspectResolutions = DisplayVideoSettings.GetSelectedAspectResolutions(selectedOption) ?? Array.Empty<Resolution>();
			for (int i = 0; i < selectedAspectResolutions.Length; i++)
			{
				Resolution resolution = selectedAspectResolutions[i];
				flag = true;
				_dropdown.options.Add(new TMP_Dropdown.OptionData($"{resolution.width} × {resolution.height}"));
			}
			_dropdown.interactable = flag;
			if (!flag)
			{
				_dropdown.options.Add(new TMP_Dropdown.OptionData(_noResolutionsErrorMessage.DisplayText));
			}
			else
			{
				_dropdown.SetValueWithoutNotify(UserSetting<int>.Get(DisplayVideoSetting.Resolution));
			}
			_dropdown.RefreshShownValue();
		}
	}
}
