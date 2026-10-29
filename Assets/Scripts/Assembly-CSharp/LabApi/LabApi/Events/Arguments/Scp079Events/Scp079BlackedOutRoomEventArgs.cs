namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079BlackedOutRoomEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRoomEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Room Room { get; }

		public Scp079BlackedOutRoomEventArgs(ReferenceHub hub, global::MapGeneration.RoomIdentifier room)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Room = global::LabApi.Features.Wrappers.Room.Get(room);
		}
	}
}
