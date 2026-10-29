namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class ScpDamagedObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public ScpDamagedObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers, ReferenceHub targetHub)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
		}
	}
}
