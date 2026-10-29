namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class EscapedObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs
	{
		public global::PlayerRoles.RoleTypeId OldRole { get; }

		public global::PlayerRoles.RoleTypeId NewRole { get; }

		public EscapedObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers, global::PlayerRoles.RoleTypeId oldRole, global::PlayerRoles.RoleTypeId newRole)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			OldRole = oldRole;
			NewRole = newRole;
		}
	}
}
