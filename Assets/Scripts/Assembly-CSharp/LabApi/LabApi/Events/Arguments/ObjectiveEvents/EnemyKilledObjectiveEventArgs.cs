namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class EnemyKilledObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public EnemyKilledObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers, ReferenceHub targetHub)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
		}
	}
}
