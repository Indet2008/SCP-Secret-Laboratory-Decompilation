namespace PlayerStatsSystem
{
	public interface IAhpProcess
	{
		float CurrentAmount { get; }

		float Limit { get; }

		float DecayRate { get; }

		float Efficacy { get; }

		float SustainTime { get; }

		bool Persistant { get; }

		int KillCode { get; }
	}
}
