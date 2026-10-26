using InventorySystem.Disarming;
using LabApi.Events.Arguments.ObjectiveEvents;
using LabApi.Events.Handlers;
using PlayerRoles;

namespace Respawning.Objectives
{
	public class EscapeObjective : HumanObjectiveBase<EscapeObjectiveFootprint>
	{
		private const float EscapeInfluence = 5f;

		private const float CuffedEscapeInfluence = 5f;

		private const float ClassDEscapeTime = -20f;

		private const float ClassDEscapeInfluence = 5f;

		private const float ScientistEscapeTime = -30f;

		private const float ScientistEscapeInfluence = 5f;

		private const float CuffedClassDEscapeTime = -10f;

		private const float CuffedClassDEscapeInfluence = 5f;

		private const float CuffedScientistEscapeTime = -20f;

		private const float CuffedScientistEscapeInfluence = 5f;

		protected override EscapeObjectiveFootprint ClientCreateFootprint()
		{
			return new EscapeObjectiveFootprint();
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		private void OnServerRoleSet(ReferenceHub hub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (reason != RoleChangeReason.Escaped)
			{
				return;
			}
			bool flag = hub.inventory.IsDisarmed();
			RoleTypeId roleTypeId = hub.roleManager.CurrentRole.RoleTypeId;
			Faction faction = hub.GetFaction();
			Faction faction2 = (flag ? GetOpposingFaction(faction) : faction);
			if (faction2 == Faction.Unclassified)
			{
				return;
			}
			float timeToGrant = 0f;
			float influenceToGrant = 0f;
			switch (roleTypeId)
			{
			case RoleTypeId.ClassD:
				timeToGrant = (flag ? (-10f) : (-20f));
				influenceToGrant = (flag ? 5f : 5f);
				break;
			case RoleTypeId.Scientist:
				timeToGrant = (flag ? (-20f) : (-30f));
				influenceToGrant = (flag ? 5f : 5f);
				break;
			}
			bool sendToPlayers = true;
			EscapingObjectiveEventArgs e = new EscapingObjectiveEventArgs(hub, faction2, influenceToGrant, timeToGrant, roleTypeId, newRole, sendToPlayers);
			ObjectiveEvents.OnEscapingCompleting(e);
			if (!e.IsAllowed)
			{
				return;
			}
			ObjectiveEvents.OnCompleting(e);
			if (e.IsAllowed)
			{
				hub = e.Player?.ReferenceHub;
				faction2 = e.Faction;
				timeToGrant = e.TimeToGrant;
				influenceToGrant = e.InfluenceToGrant;
				sendToPlayers = e.SendToPlayers;
				GrantInfluence(faction2, influenceToGrant);
				ReduceTimer(faction2, timeToGrant);
				if (sendToPlayers)
				{
					base.ObjectiveFootprint = new EscapeObjectiveFootprint
					{
						AchievingPlayer = new ObjectiveHubFootprint(hub, newRole),
						InfluenceReward = influenceToGrant,
						TimeReward = timeToGrant
					};
					ServerSendUpdate();
				}
				EscapedObjectiveEventArgs ev = new EscapedObjectiveEventArgs(hub, faction2, influenceToGrant, timeToGrant, sendToPlayers, roleTypeId, newRole);
				ObjectiveEvents.OnEscapedCompleted(ev);
				ObjectiveEvents.OnCompleted(ev);
			}
		}

		private static Faction GetOpposingFaction(Faction faction)
		{
			return faction switch
			{
				Faction.FoundationStaff => Faction.FoundationEnemy, 
				Faction.FoundationEnemy => Faction.FoundationStaff, 
				_ => Faction.Unclassified, 
			};
		}
	}
}
