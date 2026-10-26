namespace Mirror
{
	public struct ExponentialMovingAverage
	{
		private readonly double alpha;

		private bool initialized;

		public double Value;

		public double Variance;

		public double StandardDeviation;

		public ExponentialMovingAverage(int n)
		{
			alpha = 2.0 / (double)(n + 1);
			initialized = false;
			Value = 0.0;
			Variance = 0.0;
			StandardDeviation = 0.0;
		}

		public void Add(double newValue)
		{
			if (initialized)
			{
				double num = newValue - Value;
				Value += alpha * num;
				Variance = (1.0 - alpha) * (Variance + alpha * num * num);
				StandardDeviation = global::System.Math.Sqrt(Variance);
			}
			else
			{
				Value = newValue;
				initialized = true;
			}
		}

		public void Reset()
		{
			initialized = false;
			Value = 0.0;
			Variance = 0.0;
			StandardDeviation = 0.0;
		}
	}
}
