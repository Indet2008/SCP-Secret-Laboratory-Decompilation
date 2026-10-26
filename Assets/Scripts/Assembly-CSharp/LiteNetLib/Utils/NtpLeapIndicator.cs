namespace LiteNetLib.Utils
{
	public enum NtpLeapIndicator
	{
		NoWarning = 0,
		LastMinuteHas61Seconds = 1,
		LastMinuteHas59Seconds = 2,
		AlarmCondition = 3
	}
}
