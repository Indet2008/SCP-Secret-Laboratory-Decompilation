namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class GeneratorActivatingObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public GeneratorActivatingObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, global::MapGeneration.Distributors.Scp079Generator generator, bool sendToPlayers)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
