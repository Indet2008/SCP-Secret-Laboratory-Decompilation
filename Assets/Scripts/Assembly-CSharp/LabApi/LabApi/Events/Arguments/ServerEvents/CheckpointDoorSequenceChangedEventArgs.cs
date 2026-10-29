namespace LabApi.Events.Arguments.ServerEvents
{
	public class CheckpointDoorSequenceChangedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.CheckpointDoor CheckpointDoor { get; }

		public global::Interactables.Interobjects.CheckpointDoor.SequenceState CurrentSequence { get; }

		public CheckpointDoorSequenceChangedEventArgs(global::Interactables.Interobjects.CheckpointDoor door, global::Interactables.Interobjects.CheckpointDoor.SequenceState sequenceState)
		{
			CheckpointDoor = global::LabApi.Features.Wrappers.CheckpointDoor.Get(door);
			CurrentSequence = sequenceState;
		}
	}
}
