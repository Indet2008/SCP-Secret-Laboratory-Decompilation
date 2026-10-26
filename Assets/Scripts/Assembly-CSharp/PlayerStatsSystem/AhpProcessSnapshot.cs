namespace PlayerStatsSystem
{
	public readonly struct AhpProcessSnapshot : IAhpProcess
	{
		public float CurrentAmount { get; }

		public float Limit { get; }

		public float DecayRate { get; }

		public float Efficacy { get; }

		public float SustainTime { get; }

		public bool Persistant { get; }

		public int KillCode { get; }

		public AhpProcessSnapshot(AhpProcess process)
		{
			CurrentAmount = process.CurrentAmount;
			Limit = process.Limit;
			DecayRate = process.DecayRate;
			Efficacy = process.Efficacy;
			SustainTime = process.SustainTime;
			Persistant = process.Persistant;
			KillCode = process.KillCode;
		}
	}
}
