namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerEscapingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::PlayerRoles.RoleTypeId NewRole { get; set; }

		public Escape.EscapeScenarioType EscapeScenario { get; set; }

		public global::UnityEngine.Bounds EscapeZone { get; }

		public bool IsAllowed { get; set; }

		public PlayerEscapingEventArgs(ReferenceHub hub, global::PlayerRoles.RoleTypeId oldRole, global::PlayerRoles.RoleTypeId newRole, Escape.EscapeScenarioType escapeScenario, global::UnityEngine.Bounds escapeZone)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldRole = oldRole;
			NewRole = newRole;
			EscapeScenario = escapeScenario;
			EscapeZone = escapeZone;
		}
	}
}
