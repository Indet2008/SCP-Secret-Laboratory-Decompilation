namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079UnlockingDoorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IDoorEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Door Door { get; }

		public bool IsAllowed { get; set; }

		public Scp079UnlockingDoorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.DoorUtils.DoorVariant door)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			IsAllowed = true;
		}
	}
}
