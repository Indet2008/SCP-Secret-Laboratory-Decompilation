namespace MapGeneration
{
	public enum MapGenerationPhase
	{
		RoomCoordsRegistrations = 0,
		ParentRoomRegistration = 1,
		RelativePositioningWaypoints = 2,
		ComplexDecorationsAndClutter = 3,
		SimpleDecorations = 4,
		CullingCaching = 5,
		SpawnableStructures = 6,
		StaticBatching = 7
	}
}
