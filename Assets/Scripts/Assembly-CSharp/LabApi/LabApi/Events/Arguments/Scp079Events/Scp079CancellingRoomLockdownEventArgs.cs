namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079CancellingRoomLockdownEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRoomEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Room Room { get; }

		public bool IsAllowed { get; set; }

		public Scp079CancellingRoomLockdownEventArgs(ReferenceHub hub, global::MapGeneration.RoomIdentifier room)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Room = global::LabApi.Features.Wrappers.Room.Get(room);
			IsAllowed = true;
		}
	}
}
