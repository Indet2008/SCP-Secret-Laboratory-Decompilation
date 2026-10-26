using System;
using UnityEngine;

namespace FacilitySoundtrack.ChaseThemes
{
	public struct ChaseClipUtils
	{
		private readonly AudioClip _clip;

		private int _curSample;

		public const double ChaseBPM = 140.0;

		public const double SecondsPerBeat = 1755.0 / 4095.0;

		public readonly int BeatsPerBar;

		public readonly double SamplesPerBar;

		public int CurSample
		{
			readonly get
			{
				return _curSample;
			}
			set
			{
				_curSample = WrapSamples(_clip, value);
			}
		}

		public double CurSeconds
		{
			readonly get
			{
				return SamplesToSeconds(_clip, CurSample);
			}
			set
			{
				_curSample = SecondsToSamples(_clip, value);
			}
		}

		public int CurrentBar
		{
			readonly get
			{
				return (int)((double)CurSample / SamplesPerBar);
			}
			set
			{
				CurSample = (int)((double)value * SamplesPerBar + (double)SampleIntoBar);
			}
		}

		public int SampleIntoBar
		{
			readonly get
			{
				return (int)((double)CurSample % SamplesPerBar);
			}
			set
			{
				CurSample = (int)((double)CurrentBar * SamplesPerBar + (double)value);
			}
		}

		public int SamplesUntilNextBar
		{
			readonly get
			{
				return (int)(SamplesPerBar - (double)SampleIntoBar);
			}
			set
			{
				SampleIntoBar = (int)(SamplesPerBar - (double)value);
			}
		}

		public double SecondsUntilNextBar
		{
			readonly get
			{
				return SamplesToSeconds(_clip, SamplesUntilNextBar);
			}
			set
			{
				SamplesUntilNextBar = SecondsToSamples(_clip, value);
			}
		}

		public ChaseClipUtils(AudioClip sourceClip, int beatsPerBar = 4, int? curTimeSamples = null)
		{
			_curSample = 0;
			_clip = sourceClip;
			BeatsPerBar = beatsPerBar;
			SamplesPerBar = 1755.0 / 4095.0 * (double)beatsPerBar * (double)sourceClip.frequency;
			if (curTimeSamples.HasValue)
			{
				CurSample = curTimeSamples.Value;
				return;
			}
			double startingDpsTime = ChaseThemeSoundtrack.SynchronizationDpsTime ?? AudioSettings.dspTime;
			CurSample = GetSamplesElapsed(sourceClip, startingDpsTime);
		}

		public static int GetSamplesElapsed(AudioClip clip, double startingDpsTime, double? dpsNow = null)
		{
			double valueOrDefault = dpsNow.GetValueOrDefault();
			if (!dpsNow.HasValue)
			{
				valueOrDefault = AudioSettings.dspTime;
				dpsNow = valueOrDefault;
			}
			double elapsed = dpsNow.Value - startingDpsTime;
			return SecondsToSamples(clip, elapsed);
		}

		public static int SecondsToSamples(AudioClip clip, double elapsed)
		{
			int frequency = clip.frequency;
			double num = (double)clip.samples / (double)frequency;
			int samples = (int)Math.Floor(elapsed % num * (double)frequency);
			return WrapSamples(clip, samples);
		}

		public static double SamplesToSeconds(AudioClip clip, int sample)
		{
			sample = WrapSamples(clip, sample);
			return (double)sample / (double)clip.frequency;
		}

		public static int WrapSamples(AudioClip clip, int samples)
		{
			int samples2 = clip.samples;
			int num = samples % samples2;
			if (num >= 0)
			{
				return num;
			}
			return num + samples2;
		}
	}
}
