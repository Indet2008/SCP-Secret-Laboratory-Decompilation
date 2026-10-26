using PlayerRoles;

namespace Achievements.Handlers
{
	public class OvertimeHandler : AchievementHandlerBase
	{
		private const RoleTypeId TargetRole = RoleTypeId.FacilityGuard;

		internal override void OnInitialize()
		{
			RoundSummary.OnRoundEnded += OnRoundEnded;
		}

		private static void OnRoundEnded(RoundSummary.LeadingTeam leading, RoundSummary.SumInfo_ClassList sumInfo)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				PlayerRoleBase currentRole = allHub.roleManager.CurrentRole;
				bool flag;
				if ((object)currentRole != null && currentRole.RoleTypeId == RoleTypeId.FacilityGuard)
				{
					RoleChangeReason serverSpawnReason = currentRole.ServerSpawnReason;
					if (serverSpawnReason - 1 <= RoleChangeReason.RoundStart)
					{
						flag = true;
						goto IL_0043;
					}
				}
				flag = false;
				goto IL_0043;
				IL_0043:
				if (flag)
				{
					AchievementHandlerBase.ServerAchieve(allHub.connectionToClient, AchievementName.Overtime);
				}
			}
		}
	}
}
