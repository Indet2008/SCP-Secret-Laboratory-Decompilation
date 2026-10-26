namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public struct CachedRoom
	{
		public RoomRoleSpawnpoint RoomType;

		public int RoomIndex;

		public CachedRoom(RoomRoleSpawnpoint roomType, int roomIndex)
		{
			RoomType = roomType;
			RoomIndex = roomIndex;
		}
	}
}
