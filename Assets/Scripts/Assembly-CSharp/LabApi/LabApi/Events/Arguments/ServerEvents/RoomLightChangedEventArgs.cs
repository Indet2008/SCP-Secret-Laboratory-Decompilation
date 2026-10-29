namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoomLightChangedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.Room Room { get; }

		public bool NewState { get; }

		public RoomLightChangedEventArgs(global::MapGeneration.RoomIdentifier room, bool newState)
		{
			Room = global::LabApi.Features.Wrappers.Room.Get(room);
			NewState = newState;
		}
	}
}
