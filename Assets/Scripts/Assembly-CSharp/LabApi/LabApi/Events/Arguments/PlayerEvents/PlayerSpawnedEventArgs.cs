namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpawnedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayerRoleBase Role { get; }

		public bool UseSpawnPoint { get; }

		public global::UnityEngine.Vector3 SpawnLocation { get; }

		public float HorizontalRotation { get; }

		public PlayerSpawnedEventArgs(ReferenceHub hub, global::PlayerRoles.PlayerRoleBase role, bool useSpawnPoint, global::UnityEngine.Vector3 spawnLocation, float horizontalRotation)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Role = role;
			UseSpawnPoint = useSpawnPoint;
			SpawnLocation = spawnLocation;
			HorizontalRotation = horizontalRotation;
		}
	}
}
