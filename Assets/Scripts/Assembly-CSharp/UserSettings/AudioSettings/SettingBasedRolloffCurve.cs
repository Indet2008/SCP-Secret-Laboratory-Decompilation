using System;
using UnityEngine;

namespace UserSettings.AudioSettings
{
	public class SettingBasedRolloffCurve : MonoBehaviour
	{
		[Serializable]
		private struct PresetCurvePair
		{
			public int Value;

			public AnimationCurve FalloffCurve;
		}

		[SerializeField]
		private OtherAudioSetting _trackedSetting;

		[SerializeField]
		private PresetCurvePair[] _pairs;

		private AnimationCurve _defaultCurve;

		private AudioSource _srcCache;

		private AnimationCurve CurrentCurve
		{
			get
			{
				return Source.GetCustomCurve(AudioSourceCurveType.CustomRolloff);
			}
			set
			{
				Source.SetCustomCurve(AudioSourceCurveType.CustomRolloff, value);
			}
		}

		private AudioSource Source
		{
			get
			{
				if ((object)_srcCache == null)
				{
					_srcCache = GetComponent<AudioSource>();
				}
				return _srcCache;
			}
		}

		private void Awake()
		{
			_defaultCurve = Source.GetCustomCurve(AudioSourceCurveType.CustomRolloff);
			UpdateCurve(UserSetting<int>.Get(_trackedSetting));
			UserSetting<int>.AddListener(_trackedSetting, UpdateCurve);
		}

		private void OnDestroy()
		{
			UserSetting<int>.RemoveListener(_trackedSetting, UpdateCurve);
		}

		private void Reset()
		{
			if (_pairs == null || _pairs.Length == 0)
			{
				PresetCurvePair presetCurvePair = new PresetCurvePair
				{
					FalloffCurve = CurrentCurve
				};
				_pairs = new PresetCurvePair[1] { presetCurvePair };
			}
		}

		private void UpdateCurve(int settingValue)
		{
			PresetCurvePair[] pairs = _pairs;
			for (int i = 0; i < pairs.Length; i++)
			{
				PresetCurvePair presetCurvePair = pairs[i];
				if (presetCurvePair.Value == settingValue)
				{
					CurrentCurve = presetCurvePair.FalloffCurve;
					return;
				}
			}
			CurrentCurve = _defaultCurve;
		}
	}
}
