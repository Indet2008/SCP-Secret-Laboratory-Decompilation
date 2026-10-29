namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRoomChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Room? OldRoom { get; }

		public global::LabApi.Features.Wrappers.Room? NewRoom { get; }

		public PlayerRoomChangedEventArgs(ReferenceHub player, global::MapGeneration.RoomIdentifier oldRoom, global::MapGeneration.RoomIdentifier newRoom)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			OldRoom = global::LabApi.Features.Wrappers.Room.Get(oldRoom);
			NewRoom = global::LabApi.Features.Wrappers.Room.Get(newRoom);
		}
	}
}
