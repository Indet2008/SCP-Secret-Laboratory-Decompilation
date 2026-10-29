namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class GeneratorActivatedObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public GeneratorActivatedObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers, global::MapGeneration.Distributors.Scp079Generator generator)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
