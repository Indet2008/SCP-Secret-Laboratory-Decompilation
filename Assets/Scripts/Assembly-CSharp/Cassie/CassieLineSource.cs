using System;
using System.Collections.Generic;
using UnityEngine;

namespace Cassie
{
	public class CassieLineSource : MonoBehaviour
	{
		private static readonly List<AudioClip> LoadedClips = new List<AudioClip>();

		private double _lastUpdateDspTime;

		private int _remainingStutters;

		private AudioSource _src;

		public bool IsBusy { get; private set; }

		public CassieLine Line { get; private set; }

		public CassiePlaybackModifiers Modifiers { get; private set; }

		public double ScheduledStartTime { get; private set; }

		public double ScheduledEndTime { get; private set; }

		public static event Action<CassieLineSource> OnStartedPlaying;

		public void Schedule(CassieLine cassieLine, double startDspTime, CassiePlaybackModifiers modifiers)
		{
			AudioClip clip = cassieLine.Clip;
			if (clip.loadState == AudioDataLoadState.Unloaded)
			{
				LoadedClips.Add(clip);
				clip.LoadAudioData();
			}
			startDspTime += (double)modifiers.Sleep.GetValueOrDefault();
			float value = (float)clip.frequency * modifiers.StartTime.GetValueOrDefault();
			value = Mathf.Clamp(value, 0f, clip.samples - 1);
			double num = (modifiers.MaxDuration ?? clip.length) / (modifiers.Pitch ?? 1f);
			double num2 = modifiers.Stutter?.DurationCost ?? 0.0;
			double scheduledEndTime = startDspTime + num + num2;
			_src.clip = clip;
			_src.timeSamples = (int)value;
			_src.volume = modifiers.Volume ?? 1f;
			_src.pitch = modifiers.Pitch ?? 1f;
			Line = cassieLine;
			IsBusy = true;
			Modifiers = modifiers;
			ScheduledStartTime = startDspTime;
			ScheduledEndTime = scheduledEndTime;
			_src.PlayScheduled(startDspTime);
			_src.SetScheduledEndTime(scheduledEndTime);
			_remainingStutters = modifiers.Stutter?.Repetitions ?? 0;
		}

		public void Clear()
		{
			_src.Stop();
			_remainingStutters = 0;
			IsBusy = false;
		}

		public void UpdateSpatialization(CassieLineSource template)
		{
			_src.volume = template._src.volume * (Modifiers.Volume ?? 1f);
			_src.spatialBlend = template._src.spatialBlend;
			_src.spread = template._src.spread;
		}

		private void Awake()
		{
			_src = GetComponent<AudioSource>();
		}

		private void Update()
		{
			if (IsBusy)
			{
				UpdateStutter();
				double dspTime = AudioSettings.dspTime;
				if (_lastUpdateDspTime < ScheduledStartTime && dspTime >= ScheduledStartTime)
				{
					OnStartedPlaying?.Invoke(this);
				}
				if (dspTime > ScheduledEndTime)
				{
					IsBusy = false;
				}
				_lastUpdateDspTime = dspTime;
			}
		}

		private void UpdateStutter()
		{
			if (_remainingStutters <= 0)
			{
				return;
			}
			CassieStutterSettings value = Modifiers.Stutter.Value;
			float num = value.StartNormalizedTime * Line.Clip.length;
			float num2 = _src.time;
			bool flag = false;
			while (num2 >= num + value.RepeatedLength)
			{
				_remainingStutters--;
				num2 -= value.RepeatedLength;
				flag = true;
				if (_remainingStutters <= 0)
				{
					break;
				}
			}
			if (flag)
			{
				_src.time = Mathf.Max(0f, num2);
			}
		}

		public static void UpdateUnusedClips()
		{
			for (int i = 0; i < 4; i++)
			{
				int num = LoadedClips.Count - i - 1;
				if (num < 0)
				{
					break;
				}
				LoadedClips[num].UnloadAudioData();
				LoadedClips.RemoveAt(num);
			}
		}
	}
}
