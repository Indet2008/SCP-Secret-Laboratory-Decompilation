namespace LabApi.Events.Arguments.ServerEvents
{
	public class MapGeneratedEventArgs : global::System.EventArgs
	{
		public int Seed { get; }

		public MapGeneratedEventArgs(int seed)
		{
			Seed = seed;
		}
	}
}
