namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class ScpDamagingObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public ScpDamagingObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, ReferenceHub targetHub, bool sendToPlayers)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
		}
	}
}
