namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangedRoleEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::PlayerRoles.PlayerRoleBase NewRole { get; }

		public global::PlayerRoles.RoleChangeReason ChangeReason { get; }

		public global::PlayerRoles.RoleSpawnFlags SpawnFlags { get; }

		public PlayerChangedRoleEventArgs(ReferenceHub hub, global::PlayerRoles.RoleTypeId oldRole, global::PlayerRoles.PlayerRoleBase newRole, global::PlayerRoles.RoleChangeReason changeReason, global::PlayerRoles.RoleSpawnFlags spawnFlags)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldRole = oldRole;
			NewRole = newRole;
			ChangeReason = changeReason;
			SpawnFlags = spawnFlags;
		}
	}
}
