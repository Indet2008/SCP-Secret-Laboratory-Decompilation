namespace Mirror
{
	public struct Stats
	{
		public int connections;

		public double uptime;

		public int configuredTickRate;

		public int actualTickRate;

		public long sentBytesPerSecond;

		public long receiveBytesPerSecond;

		public float serverTickInterval;

		public double fullUpdateAvg;

		public double serverEarlyAvg;

		public double serverLateAvg;

		public double transportEarlyAvg;

		public double transportLateAvg;

		public Stats(int connections, double uptime, int configuredTickRate, int actualTickRate, long sentBytesPerSecond, long receiveBytesPerSecond, float serverTickInterval, double fullUpdateAvg, double serverEarlyAvg, double serverLateAvg, double transportEarlyAvg, double transportLateAvg)
		{
			this.connections = connections;
			this.uptime = uptime;
			this.configuredTickRate = configuredTickRate;
			this.actualTickRate = actualTickRate;
			this.sentBytesPerSecond = sentBytesPerSecond;
			this.receiveBytesPerSecond = receiveBytesPerSecond;
			this.serverTickInterval = serverTickInterval;
			this.fullUpdateAvg = fullUpdateAvg;
			this.serverEarlyAvg = serverEarlyAvg;
			this.serverLateAvg = serverLateAvg;
			this.transportEarlyAvg = transportEarlyAvg;
			this.transportLateAvg = transportLateAvg;
		}
	}
}
