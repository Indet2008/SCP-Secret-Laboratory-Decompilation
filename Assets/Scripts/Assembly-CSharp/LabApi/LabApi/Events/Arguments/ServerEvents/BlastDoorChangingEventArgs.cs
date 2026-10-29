namespace LabApi.Events.Arguments.ServerEvents
{
	public class BlastDoorChangingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public BlastDoor BlastDoor { get; }

		public bool NewState { get; set; }

		public bool IsAllowed { get; set; }

		public BlastDoorChangingEventArgs(BlastDoor blastDoor, bool newState)
		{
			BlastDoor = blastDoor;
			NewState = newState;
			IsAllowed = true;
		}
	}
}
