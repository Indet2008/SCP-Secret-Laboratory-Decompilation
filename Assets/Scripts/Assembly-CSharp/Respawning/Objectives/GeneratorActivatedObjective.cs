using Footprinting;
using LabApi.Events.Arguments.ObjectiveEvents;
using LabApi.Events.Handlers;
using MapGeneration.Distributors;
using PlayerRoles;
using Utils.NonAllocLINQ;

namespace Respawning.Objectives
{
	public class GeneratorActivatedObjective : HumanObjectiveBase<GeneratorObjectiveFootprint>
	{
		private const float GeneratorActivatedTimer = -10f;

		private const float GeneratorActivatedInfluence = 3f;

		protected override GeneratorObjectiveFootprint ClientCreateFootprint()
		{
			return new GeneratorObjectiveFootprint();
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			Scp079Generator.OnGeneratorEngaged += OnGeneratorEngaged;
		}

		private void OnGeneratorEngaged(Scp079Generator generator, Footprint footprint)
		{
			bool num = ReferenceHub.AllHubs.Any((ReferenceHub hub) => hub.GetRoleId() == RoleTypeId.Scp079);
			Faction faction = footprint.Role.GetFaction();
			float timeToGrant = (num ? (-10f) : 0f);
			float influenceToGrant = (num ? 3f : 0f);
			bool sendToPlayers = num;
			GeneratorActivatingObjectiveEventArgs e = new GeneratorActivatingObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, generator, sendToPlayers);
			ObjectiveEvents.OnActivatingGeneratorCompleting(e);
			if (!e.IsAllowed)
			{
				return;
			}
			ObjectiveEvents.OnCompleting(e);
			if (e.IsAllowed)
			{
				if (footprint.Hub != e.Player.ReferenceHub)
				{
					footprint = new Footprint(e.Player?.ReferenceHub);
				}
				faction = e.Faction;
				timeToGrant = e.TimeToGrant;
				influenceToGrant = e.InfluenceToGrant;
				sendToPlayers = e.SendToPlayers;
				GrantInfluence(faction, influenceToGrant);
				ReduceTimer(faction, timeToGrant);
				if (sendToPlayers)
				{
					base.ObjectiveFootprint = new GeneratorObjectiveFootprint
					{
						AchievingPlayer = new ObjectiveHubFootprint(footprint),
						InfluenceReward = influenceToGrant,
						TimeReward = timeToGrant
					};
					ServerSendUpdate();
				}
				GeneratorActivatedObjectiveEventArgs ev = new GeneratorActivatedObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, sendToPlayers, generator);
				ObjectiveEvents.OnActivatedGeneratorCompleted(ev);
				ObjectiveEvents.OnCompleted(ev);
			}
		}
	}
}
