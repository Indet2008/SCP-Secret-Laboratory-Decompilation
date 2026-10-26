using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaDScientist : Scp1509RespawnCriteriaBase
	{
		public override RoleTypeId[] KillerRoles => new RoleTypeId[1] { RoleTypeId.Scientist };

		public override RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			if (Scp1509RespawnCriteriaBase.IsSkippableRole(victim))
			{
				return RoleTypeId.None;
			}
			int scientists = RoundSummary.singleton.classlistStart.scientists;
			if (RoundSummary.EscapedScientists + RoundSummary.singleton.CountRole(RoleTypeId.Scientist) < scientists)
			{
				return RoleTypeId.Scientist;
			}
			return RoleTypeId.FacilityGuard;
		}
	}
}
