namespace Mirror
{
	public struct TimeSample
	{
		private readonly global::System.Diagnostics.Stopwatch watch;

		private double beginTime;

		private global::Mirror.ExponentialMovingAverage ema;

		public double average;

		public TimeSample(int n)
		{
			watch = new global::System.Diagnostics.Stopwatch();
			watch.Start();
			ema = new global::Mirror.ExponentialMovingAverage(n);
			beginTime = 0.0;
			average = 0.0;
		}

		public void Begin()
		{
			beginTime = watch.Elapsed.TotalSeconds;
		}

		public void End()
		{
			double newValue = watch.Elapsed.TotalSeconds - beginTime;
			ema.Add(newValue);
			global::System.Threading.Interlocked.Exchange(ref average, ema.Value);
		}
	}
}
