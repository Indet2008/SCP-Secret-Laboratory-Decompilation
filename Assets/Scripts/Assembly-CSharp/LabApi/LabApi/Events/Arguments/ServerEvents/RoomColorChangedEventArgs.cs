namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoomColorChangedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.Room Room { get; }

		public global::UnityEngine.Color NewState { get; }

		public RoomColorChangedEventArgs(global::MapGeneration.RoomIdentifier room, global::UnityEngine.Color newState)
		{
			Room = global::LabApi.Features.Wrappers.Room.Get(room);
			NewState = newState;
		}
	}
}
