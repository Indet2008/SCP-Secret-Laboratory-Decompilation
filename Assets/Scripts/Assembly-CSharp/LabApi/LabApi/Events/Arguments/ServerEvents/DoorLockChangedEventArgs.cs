namespace LabApi.Events.Arguments.ServerEvents
{
	public class DoorLockChangedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.Door Door { get; }

		public global::Interactables.Interobjects.DoorUtils.DoorLockReason PrevLockReason { get; }

		public global::Interactables.Interobjects.DoorUtils.DoorLockReason LockReason { get; }

		public DoorLockChangedEventArgs(global::Interactables.Interobjects.DoorUtils.DoorVariant door, ushort prevLockReason, ushort activeLocks)
		{
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			PrevLockReason = (global::Interactables.Interobjects.DoorUtils.DoorLockReason)prevLockReason;
			LockReason = (global::Interactables.Interobjects.DoorUtils.DoorLockReason)activeLocks;
		}
	}
}
