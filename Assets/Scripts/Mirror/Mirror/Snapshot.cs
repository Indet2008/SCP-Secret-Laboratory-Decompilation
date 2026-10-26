namespace Mirror
{
	public interface Snapshot
	{
		double remoteTime { get; set; }

		double localTime { get; set; }
	}
}
