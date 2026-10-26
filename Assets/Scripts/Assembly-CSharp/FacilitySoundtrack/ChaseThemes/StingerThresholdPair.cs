using System;
using UnityEngine;

namespace FacilitySoundtrack.ChaseThemes
{
	[Serializable]
	public class StingerThresholdPair
	{
		public AudioClip Clip;

		public float Threshold;

		public static StingerThresholdPair GetBest(StingerThresholdPair[] pairs, float val)
		{
			foreach (StingerThresholdPair stingerThresholdPair in pairs)
			{
				if (!(stingerThresholdPair.Threshold > val))
				{
					return stingerThresholdPair;
				}
			}
			return null;
		}
	}
}
