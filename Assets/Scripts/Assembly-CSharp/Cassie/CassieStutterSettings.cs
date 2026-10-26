using UnityEngine;

namespace Cassie
{
	public struct CassieStutterSettings
	{
		public float StartNormalizedTime;

		public float RepeatedLength;

		public int Repetitions;

		public readonly double DurationCost => RepeatedLength * (float)Repetitions;

		public CassieStutterSettings(float startNormalizedTime, float repeatedLength, int repetitions)
		{
			StartNormalizedTime = Mathf.Clamp01(startNormalizedTime);
			RepeatedLength = Mathf.Max(repeatedLength, 0f);
			Repetitions = Mathf.Max(repetitions, 1);
		}
	}
}
