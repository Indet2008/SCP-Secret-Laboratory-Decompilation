namespace LabApi.Events.Arguments.ServerEvents
{
	public class CheckpointDoorSequenceChangingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.CheckpointDoor CheckpointDoor { get; }

		public global::Interactables.Interobjects.CheckpointDoor.SequenceState CurrentSequence { get; }

		public global::Interactables.Interobjects.CheckpointDoor.SequenceState NewSequence { get; set; }

		public bool IsAllowed { get; set; }

		public CheckpointDoorSequenceChangingEventArgs(global::Interactables.Interobjects.CheckpointDoor door, global::Interactables.Interobjects.CheckpointDoor.SequenceState oldState, global::Interactables.Interobjects.CheckpointDoor.SequenceState sequenceState)
		{
			CheckpointDoor = global::LabApi.Features.Wrappers.CheckpointDoor.Get(door);
			CurrentSequence = oldState;
			NewSequence = sequenceState;
			IsAllowed = true;
		}
	}
}
