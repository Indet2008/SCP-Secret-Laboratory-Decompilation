namespace Mirror
{
	public static class AccurateInterval
	{
		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool Elapsed(double time, double interval, ref double lastTime)
		{
			if (time < lastTime + interval)
			{
				return false;
			}
			long num = (long)(time / interval);
			lastTime = (double)num * interval;
			return true;
		}
	}
}
