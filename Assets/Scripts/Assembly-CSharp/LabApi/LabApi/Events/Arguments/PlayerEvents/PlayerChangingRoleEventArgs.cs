namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingRoleEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayerRoleBase OldRole { get; }

		public global::PlayerRoles.RoleTypeId NewRole { get; set; }

		public global::PlayerRoles.RoleChangeReason ChangeReason { get; set; }

		public global::PlayerRoles.RoleSpawnFlags SpawnFlags { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerChangingRoleEventArgs(ReferenceHub hub, global::PlayerRoles.PlayerRoleBase oldRole, global::PlayerRoles.RoleTypeId newRole, global::PlayerRoles.RoleChangeReason changeReason, global::PlayerRoles.RoleSpawnFlags spawnFlags)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldRole = oldRole;
			NewRole = newRole;
			ChangeReason = changeReason;
			SpawnFlags = spawnFlags;
		}
	}
}
