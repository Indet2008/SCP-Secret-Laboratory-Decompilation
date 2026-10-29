namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDeathEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Attacker { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::UnityEngine.Vector3 OldPosition { get; }

		public global::UnityEngine.Vector3 OldVelocity { get; }

		public global::UnityEngine.Quaternion OldCameraRotation { get; }

		public PlayerDeathEventArgs(ReferenceHub hub, ReferenceHub? attacker, global::PlayerStatsSystem.DamageHandlerBase damageHandler, global::PlayerRoles.RoleTypeId oldRole, global::UnityEngine.Vector3 oldPosition, global::UnityEngine.Vector3 oldVelocity, global::UnityEngine.Quaternion oldCameraRotation)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			DamageHandler = damageHandler;
			OldRole = oldRole;
			OldPosition = oldPosition;
			OldVelocity = oldVelocity;
			OldCameraRotation = oldCameraRotation;
		}
	}
}
