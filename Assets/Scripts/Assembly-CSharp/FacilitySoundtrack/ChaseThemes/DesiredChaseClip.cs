using UnityEngine;

namespace FacilitySoundtrack.ChaseThemes
{
	public readonly struct DesiredChaseClip
	{
		public readonly struct Offset
		{
			public readonly double SchedulingDelay;

			public readonly int StartSamples;

			public readonly bool DontSyncWithOthers;

			public Offset(double schedulingDelaySeconds, int startSamples, bool dontSyncWithOthers = false)
			{
				if (schedulingDelaySeconds < 0.0)
				{
					schedulingDelaySeconds = 0.0;
					Debug.LogError("Attempting to schedule playback in the past.");
				}
				SchedulingDelay = schedulingDelaySeconds;
				StartSamples = startSamples;
				DontSyncWithOthers = dontSyncWithOthers;
			}
		}

		public readonly AudioClip Clip;

		public readonly float TrackVolume;

		public readonly float VolumeIncreaseSpeed;

		public readonly float VolumeDecreaseSpeed;

		public readonly Offset? JoinOffset;

		public DesiredChaseClip(AudioClip clip, float trackVolume = 1f, float volumeIncSpeed = 10f, float volumeDecSpeed = 10f, Offset? offset = null)
		{
			Clip = clip;
			TrackVolume = trackVolume;
			VolumeIncreaseSpeed = volumeIncSpeed;
			VolumeDecreaseSpeed = volumeDecSpeed;
			JoinOffset = offset;
		}
	}
}
