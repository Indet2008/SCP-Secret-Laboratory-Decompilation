using PlayerRoles;

namespace Achievements.Handlers
{
	public class CompleteTheMissionHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			RoundSummary.OnRoundEnded += OnRoundEnded;
		}

		private static void OnRoundEnded(RoundSummary.LeadingTeam leadingTeam, RoundSummary.SumInfo_ClassList sumInfo)
		{
			ReferenceHub referenceHub = null;
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				Team team = allHub.GetTeam();
				if (team != Team.Dead && leadingTeam == GetLeadingTeam(team))
				{
					num++;
					referenceHub = allHub;
					if (num > 1)
					{
						break;
					}
				}
			}
			if (num == 1)
			{
				AchievementHandlerBase.ServerAchieve(referenceHub.connectionToClient, AchievementName.CompleteTheMission);
			}
		}

		private static RoundSummary.LeadingTeam GetLeadingTeam(Team team)
		{
			switch (team)
			{
			case Team.ChaosInsurgency:
			case Team.ClassD:
				return RoundSummary.LeadingTeam.ChaosInsurgency;
			case Team.FoundationForces:
			case Team.Scientists:
				return RoundSummary.LeadingTeam.FacilityForces;
			case Team.SCPs:
				return RoundSummary.LeadingTeam.Anomalies;
			default:
				return RoundSummary.LeadingTeam.Draw;
			}
		}
	}
}
