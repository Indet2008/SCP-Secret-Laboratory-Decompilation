using System.Collections.Generic;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class LerpAudioMixerVisuals : LerpVisualsBase
	{
		[SerializeField]
		private string _mixerFloatName;

		[SerializeField]
		private float _mixerTargetValue;

		private PlayerEffectsController _playerEffectsController;

		private float _defaultMixerValue;

		private static readonly Dictionary<string, float> DefaultValues = new Dictionary<string, float>();

		protected override void Awake()
		{
			base.Awake();
			_playerEffectsController = base.TargetEffect.Hub.playerEffectsController;
			if (DefaultValues.TryGetValue(_mixerFloatName, out var value))
			{
				_defaultMixerValue = value;
			}
			else if (_playerEffectsController.mixer.GetFloat(_mixerFloatName, out _defaultMixerValue))
			{
				DefaultValues.Add(_mixerFloatName, _defaultMixerValue);
			}
		}

		protected override void OnWeightChanged(float weight)
		{
			_playerEffectsController.mixer.SetFloat(_mixerFloatName, Mathf.Lerp(_defaultMixerValue, _mixerTargetValue, Mathf.Clamp01(weight)));
		}
	}
}
