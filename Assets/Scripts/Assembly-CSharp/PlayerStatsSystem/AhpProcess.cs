namespace PlayerStatsSystem
{
	public class AhpProcess : IAhpProcess
	{
		private static int _killCodeAI;

		public float CurrentAmount { get; set; }

		public float Limit { get; set; }

		public float DecayRate { get; set; }

		public float Efficacy { get; set; }

		public float SustainTime { get; set; }

		public bool Persistant { get; }

		public int KillCode { get; }

		public AhpProcess(float startAmount, float limit, float decay, float efficacy, float sustain, bool persistant)
		{
			_killCodeAI++;
			CurrentAmount = startAmount;
			Limit = limit;
			DecayRate = decay;
			Efficacy = efficacy;
			SustainTime = sustain;
			Persistant = persistant;
			KillCode = _killCodeAI;
		}

		public void OverrideProcess(IAhpProcess process)
		{
			CurrentAmount = process.CurrentAmount;
			Limit = process.Limit;
			DecayRate = process.DecayRate;
			Efficacy = process.Efficacy;
			SustainTime = process.SustainTime;
		}

		public AhpProcessSnapshot CreateSnapshot()
		{
			return new AhpProcessSnapshot(this);
		}
	}
}
