using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaDClass : Scp1509RespawnCriteriaBase
	{
		public override RoleTypeId[] KillerRoles => new RoleTypeId[1] { RoleTypeId.ClassD };

		public override RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			if (Scp1509RespawnCriteriaBase.IsSkippableRole(victim))
			{
				return RoleTypeId.None;
			}
			int class_ds = RoundSummary.singleton.classlistStart.class_ds;
			if (RoundSummary.EscapedClassD + RoundSummary.singleton.CountRole(RoleTypeId.ClassD) < class_ds)
			{
				return RoleTypeId.ClassD;
			}
			return RoleTypeId.ChaosConscript;
		}
	}
}
