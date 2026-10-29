namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079LockedDoorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IDoorEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Door Door { get; }

		public Scp079LockedDoorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.DoorUtils.DoorVariant door)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
		}
	}
}
