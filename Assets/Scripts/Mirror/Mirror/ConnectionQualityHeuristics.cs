namespace Mirror
{
	public static class ConnectionQualityHeuristics
	{
		public static global::UnityEngine.Color ColorCode(this global::Mirror.ConnectionQuality quality)
		{
			return quality switch
			{
				global::Mirror.ConnectionQuality.EXCELLENT => global::UnityEngine.Color.green, 
				global::Mirror.ConnectionQuality.GOOD => global::UnityEngine.Color.yellow, 
				global::Mirror.ConnectionQuality.FAIR => new global::UnityEngine.Color(1f, 0.647f, 0f), 
				global::Mirror.ConnectionQuality.POOR => global::UnityEngine.Color.red, 
				_ => global::UnityEngine.Color.gray, 
			};
		}

		public static global::Mirror.ConnectionQuality Simple(double rtt, double jitter)
		{
			if (rtt <= 0.1 && jitter <= 0.1)
			{
				return global::Mirror.ConnectionQuality.EXCELLENT;
			}
			if (rtt <= 0.2 && jitter <= 0.2)
			{
				return global::Mirror.ConnectionQuality.GOOD;
			}
			if (rtt <= 0.4 && jitter <= 0.5)
			{
				return global::Mirror.ConnectionQuality.FAIR;
			}
			return global::Mirror.ConnectionQuality.POOR;
		}

		public static global::Mirror.ConnectionQuality Pragmatic(double targetBufferTime, double currentBufferTime)
		{
			double num = currentBufferTime / targetBufferTime;
			if (num <= 1.15)
			{
				return global::Mirror.ConnectionQuality.EXCELLENT;
			}
			if (num <= 1.25)
			{
				return global::Mirror.ConnectionQuality.GOOD;
			}
			if (num <= 1.5)
			{
				return global::Mirror.ConnectionQuality.FAIR;
			}
			return global::Mirror.ConnectionQuality.POOR;
		}
	}
}
