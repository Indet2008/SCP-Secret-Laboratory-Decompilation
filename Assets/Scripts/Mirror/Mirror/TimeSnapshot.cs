namespace Mirror
{
	public struct TimeSnapshot : global::Mirror.Snapshot
	{
		public double remoteTime { get; set; }

		public double localTime { get; set; }

		public TimeSnapshot(double remoteTime, double localTime)
		{
			this.remoteTime = remoteTime;
			this.localTime = localTime;
		}
	}
}
