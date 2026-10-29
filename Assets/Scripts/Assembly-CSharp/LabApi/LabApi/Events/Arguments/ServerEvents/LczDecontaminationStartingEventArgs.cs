namespace LabApi.Events.Arguments.ServerEvents
{
	public class LczDecontaminationStartingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; } = true;
	}
}
