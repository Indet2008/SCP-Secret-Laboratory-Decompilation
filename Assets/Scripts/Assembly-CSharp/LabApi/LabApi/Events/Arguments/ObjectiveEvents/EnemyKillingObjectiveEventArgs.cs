namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class EnemyKillingObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public EnemyKillingObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, ReferenceHub targetHub, bool sendToPlayers)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
		}
	}
}
