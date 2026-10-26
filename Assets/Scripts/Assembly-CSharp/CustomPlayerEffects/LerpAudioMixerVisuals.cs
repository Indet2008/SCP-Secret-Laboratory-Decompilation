using UnityEngine;
using UnityEngine.Audio;

namespace CustomPlayerEffects
{
	public class LerpAudioMixerVisuals : LerpVisualsBase
	{
		[SerializeField]
		private string _mixerFloatName;

		[SerializeField]
		private float _mixerTargetValue;

		private float? _defaultValue;

		protected override void ApplyWeight(float weight)
		{
			AudioMixer audioMixer = ((base.Effect != null && base.Effect.Hub != null) ? base.Effect.Hub.playerEffectsController.mixer : null);
			if (audioMixer == null || string.IsNullOrEmpty(_mixerFloatName))
			{
				return;
			}
			if (!_defaultValue.HasValue)
			{
				if (!audioMixer.GetFloat(_mixerFloatName, out var value))
				{
					return;
				}
				_defaultValue = value;
			}
			audioMixer.SetFloat(_mixerFloatName, Mathf.Lerp(_defaultValue.Value, _mixerTargetValue, weight));
		}
	}
}
