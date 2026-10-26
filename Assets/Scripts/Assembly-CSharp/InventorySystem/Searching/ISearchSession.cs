namespace InventorySystem.Searching
{
	public interface ISearchSession
	{
		ISearchable Target { get; set; }

		double InitialTime { get; set; }

		double FinishTime { get; set; }

		double Progress { get; }
	}
}
