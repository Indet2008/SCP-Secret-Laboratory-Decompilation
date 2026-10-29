namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoundStartingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public RoundStartingEventArgs()
		{
			IsAllowed = true;
		}
	}
}
