namespace LabApi.Events.Arguments.ServerEvents
{
	public class DeadmanSequenceActivatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; } = true;
	}
}
