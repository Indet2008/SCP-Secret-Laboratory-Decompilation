namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpawningEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		private global::UnityEngine.Vector3 _spawnLocation;

		private float _horizontalRotation;

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayerRoleBase Role { get; }

		public bool UseSpawnPoint { get; set; }

		public global::UnityEngine.Vector3 SpawnLocation
		{
			get
			{
				return _spawnLocation;
			}
			set
			{
				UseSpawnPoint = true;
				Role.ServerSpawnFlags |= global::PlayerRoles.RoleSpawnFlags.UseSpawnpoint;
				_spawnLocation = value;
			}
		}

		public float HorizontalRotation
		{
			get
			{
				return _horizontalRotation;
			}
			set
			{
				UseSpawnPoint = true;
				Role.ServerSpawnFlags |= global::PlayerRoles.RoleSpawnFlags.UseSpawnpoint;
				_horizontalRotation = value;
			}
		}

		public bool IsAllowed { get; set; }

		public PlayerSpawningEventArgs(ReferenceHub hub, global::PlayerRoles.PlayerRoleBase role, bool useSpawnPoint, global::UnityEngine.Vector3 spawnLocation, float horizontalRotation)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Role = role;
			UseSpawnPoint = useSpawnPoint;
			_spawnLocation = spawnLocation;
			_horizontalRotation = horizontalRotation;
		}

		public void SetSpawnpoint(global::UnityEngine.Vector3 position, float horizontalRotation = 0f)
		{
			UseSpawnPoint = true;
			Role.ServerSpawnFlags |= global::PlayerRoles.RoleSpawnFlags.UseSpawnpoint;
			_spawnLocation = position;
			_horizontalRotation = horizontalRotation;
		}
	}
}
