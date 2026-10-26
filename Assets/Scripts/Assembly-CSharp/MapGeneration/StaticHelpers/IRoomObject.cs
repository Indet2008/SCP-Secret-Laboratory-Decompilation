namespace MapGeneration.StaticHelpers
{
	public interface IRoomObject
	{
		RoomIdentifier OriginalRoom { get; set; }

		void RefreshRoom();
	}
}
