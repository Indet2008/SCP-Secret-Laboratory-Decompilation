namespace RelativePositioning
{
	public interface IBacktrackableWaypoint
	{
		void Backtrack(double lagCompensation);
	}
}
