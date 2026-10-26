using GameCore;

namespace Christmas.Scp2536
{
	public interface ITimeLimitedGift
	{
		float SecondsUntilAvailable { get; }

		float SecondsUntilUnavailable { get; }

		bool IsAvailable
		{
			get
			{
				double totalSeconds = RoundStart.RoundLength.TotalSeconds;
				if (totalSeconds > (double)SecondsUntilAvailable)
				{
					return totalSeconds < (double)SecondsUntilUnavailable;
				}
				return false;
			}
		}
	}
}
