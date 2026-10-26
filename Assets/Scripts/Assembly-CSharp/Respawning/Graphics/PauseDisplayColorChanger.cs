using System;
using Respawning.Waves;
using UnityEngine;
using UnityEngine.UI;

namespace Respawning.Graphics
{
	public class PauseDisplayColorChanger : SerializedWaveInterface
	{
		public Graphic[] TargetGraphics;

		public Color DefaultColor;

		public Color PausedColor;

		public AnimationCurve BlinkingAnimation;

		private TimeBasedWave _timeBasedWave;

		private bool _isTimeBased;

		private bool _blinkTimer;

		protected override void Awake()
		{
			base.Awake();
			if (!(base.Wave is TimeBasedWave timeBasedWave))
			{
				throw new NullReferenceException("Unable to convert " + base.Wave.GetType().Name + " to TimeBasedWave.");
			}
			_timeBasedWave = timeBasedWave;
			_isTimeBased = true;
			WaveManager.OnWaveUpdateMsgReceived += OnWaveUpdateMsgReceived;
		}

		private void OnWaveUpdateMsgReceived(WaveUpdateMessage msg)
		{
			if (_timeBasedWave == msg.Wave)
			{
				if (msg.IsTrigger)
				{
					_blinkTimer = true;
				}
				else if (msg.IsSpawn)
				{
					_blinkTimer = false;
				}
			}
		}

		private void Update()
		{
			if (_isTimeBased)
			{
				if (_blinkTimer)
				{
					float t = BlinkingAnimation.Evaluate(Time.time);
					Color color = Color.Lerp(PausedColor, DefaultColor, t);
					ModifyGraphicColors(color);
				}
				else if (_timeBasedWave.Timer.IsPaused)
				{
					ModifyGraphicColors(PausedColor);
				}
				else
				{
					ModifyGraphicColors(DefaultColor);
				}
			}
		}

		private void ModifyGraphicColors(Color color)
		{
			Graphic[] targetGraphics = TargetGraphics;
			for (int i = 0; i < targetGraphics.Length; i++)
			{
				targetGraphics[i].color = color;
			}
		}
	}
}
