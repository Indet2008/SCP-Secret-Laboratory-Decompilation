namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerEscapedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::PlayerRoles.RoleTypeId NewRole { get; }

		public Escape.EscapeScenarioType EscapeScenarioType { get; }

		public global::UnityEngine.Bounds EscapeZone { get; }

		public PlayerEscapedEventArgs(ReferenceHub hub, global::PlayerRoles.RoleTypeId oldRole, global::PlayerRoles.RoleTypeId newRole, Escape.EscapeScenarioType escapeScenarioType, global::UnityEngine.Bounds escapeZone)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldRole = oldRole;
			NewRole = newRole;
			EscapeScenarioType = escapeScenarioType;
			EscapeZone = escapeZone;
		}
	}
}
