namespace LabApi.Events.Arguments.ServerEvents
{
	public class BlastDoorChangedEventArgs : global::System.EventArgs
	{
		public BlastDoor BlastDoor { get; }

		public bool NewState { get; }

		public BlastDoorChangedEventArgs(BlastDoor blastDoor, bool newState)
		{
			BlastDoor = blastDoor;
			NewState = newState;
		}
	}
}
