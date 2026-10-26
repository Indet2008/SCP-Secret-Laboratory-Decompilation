using System;

namespace Cassie
{
	public struct CassiePlaybackModifiers
	{
		public float? Pitch;

		public float? Volume;

		public float? StartTime;

		public float? MaxDuration;

		public float? Sleep;

		public float? SpacingOverride;

		public CassieStutterSettings? Stutter;

		public readonly double GetTimeUntilNextWord(CassieLine clip)
		{
			if (SpacingOverride.HasValue)
			{
				return SpacingOverride.Value;
			}
			double num = clip.Duration;
			if (Pitch.HasValue)
			{
				num /= (double)Pitch.Value;
			}
			if (StartTime.HasValue)
			{
				num -= (double)StartTime.Value;
			}
			if (MaxDuration.HasValue)
			{
				num = Math.Min(num, MaxDuration.Value);
			}
			if (Stutter.HasValue)
			{
				num += Stutter.Value.DurationCost;
			}
			if (Sleep.HasValue)
			{
				num += (double)Sleep.Value;
			}
			return num;
		}

		public void ResetSingleUseModifiers()
		{
			StartTime = null;
			MaxDuration = null;
			SpacingOverride = null;
			Stutter = null;
		}
	}
}
