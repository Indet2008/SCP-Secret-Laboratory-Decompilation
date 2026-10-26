using System;
using Respawning.Waves;
using UnityEngine;
using UnityEngine.UI;

namespace Respawning.Graphics
{
	public class WaveTimerDisplay : SerializedWaveInterface
	{
		[SerializeField]
		private Slider _slider;

		private bool _isTimeBased;

		private TimeBasedWave _timeBasedWave;

		private float NormalizedTimerValue
		{
			get
			{
				float num = Mathf.Max(_timeBasedWave.Timer.SpawnIntervalSeconds, 1f);
				float num2 = (Mathf.Clamp(_timeBasedWave.Timer.TimePassed, 0f, num) - 0f) / (num - 0f);
				return 1f - num2;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			if (!(base.Wave is TimeBasedWave timeBasedWave))
			{
				throw new NullReferenceException("Unable to convert " + base.Wave.GetType().Name + " to TimeBasedWave.");
			}
			_timeBasedWave = timeBasedWave;
			_isTimeBased = true;
		}

		private void Update()
		{
			if (_isTimeBased)
			{
				_slider.value = NormalizedTimerValue;
			}
		}
	}
}
