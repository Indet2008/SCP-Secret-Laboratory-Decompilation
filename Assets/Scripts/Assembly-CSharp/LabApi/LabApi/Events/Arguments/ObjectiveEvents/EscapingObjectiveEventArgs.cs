namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class EscapingObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs
	{
		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::PlayerRoles.RoleTypeId NewRole { get; }

		public EscapingObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, global::PlayerRoles.RoleTypeId oldRole, global::PlayerRoles.RoleTypeId newRole, bool sendToPlayers)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			OldRole = oldRole;
			NewRole = newRole;
		}
	}
}
