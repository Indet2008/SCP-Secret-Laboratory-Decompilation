using System;
using UnityEngine;

namespace Cassie
{
	public class CassieBackgroundPlayer : MonoBehaviour
	{
		[Serializable]
		private struct SpecificTransitionPoint
		{
			public float MaxDuration;

			public float TransitionTime;
		}

		public const float AnnouncementStart = 2.5f;

		public const float AnnouncementEnd = 29.1f;

		public const float EndCooldown = 3.1f;

		private double? _transitionTime;

		[Header("Starting")]
		[SerializeField]
		private AudioSource _startingSource;

		[SerializeField]
		private AnimationCurve _startingSourceTransitionCurve;

		[Header("Ending")]
		[SerializeField]
		private AudioSource _endingSource;

		[SerializeField]
		private AnimationCurve _endingSourceTransitionCurve;

		[Header("Shared")]
		[SerializeField]
		private float _minDuration;

		[SerializeField]
		private AnimationCurve _transitionTimeOverDuration;

		public void Play(double startingTime, double endingTime)
		{
			Clear();
			double num = endingTime - startingTime;
			if (num < (double)_minDuration)
			{
				num = _minDuration;
				endingTime = startingTime + (double)_minDuration;
			}
			PlayScheduled(_startingSource, startingTime);
			PlayScheduled(_endingSource, endingTime - 29.100000381469727);
			AnnouncementSource.SetVolumeScale(_startingSource, 1f);
			AnnouncementSource.SetVolumeScale(_endingSource, 0f);
			_transitionTime = startingTime + (double)_transitionTimeOverDuration.Evaluate((float)num);
		}

		public void Clear()
		{
			_transitionTime = null;
			_startingSource.Stop();
			_endingSource.Stop();
		}

		private void Update()
		{
			if (!_transitionTime.HasValue)
			{
				return;
			}
			double dspTime = AudioSettings.dspTime;
			if (!(dspTime < _transitionTime.Value))
			{
				float num = (float)(dspTime - _transitionTime.Value) / 0.8f;
				AnnouncementSource.SetVolumeScale(_startingSource, _startingSourceTransitionCurve.Evaluate(num));
				AnnouncementSource.SetVolumeScale(_endingSource, _endingSourceTransitionCurve.Evaluate(num));
				if (!(num < 1f))
				{
					_transitionTime = null;
				}
			}
		}

		private static void PlayScheduled(AudioSource src, double startingTime)
		{
			double dspTime = AudioSettings.dspTime;
			startingTime -= 0.15000000596046448;
			if (startingTime - dspTime < 0.0)
			{
				double num = (dspTime - startingTime) * (double)src.clip.frequency;
				if (!(num < 0.0) && !(num >= (double)src.clip.samples))
				{
					src.timeSamples = (int)num;
					src.PlayScheduled(0.15000000596046448);
				}
			}
			else
			{
				src.timeSamples = 0;
				src.PlayScheduled(startingTime + 0.15000000596046448);
			}
		}
	}
}
