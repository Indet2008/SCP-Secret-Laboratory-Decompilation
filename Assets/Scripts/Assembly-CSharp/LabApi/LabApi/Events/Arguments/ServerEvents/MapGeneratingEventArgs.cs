namespace LabApi.Events.Arguments.ServerEvents
{
	public class MapGeneratingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public int Seed { get; set; }

		public bool IsAllowed { get; set; }

		public MapGeneratingEventArgs(int seed)
		{
			IsAllowed = true;
			Seed = seed;
		}
	}
}
