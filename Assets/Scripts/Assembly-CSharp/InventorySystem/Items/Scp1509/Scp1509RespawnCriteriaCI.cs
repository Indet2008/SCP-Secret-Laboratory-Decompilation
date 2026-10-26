using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaCI : Scp1509RespawnCriteriaBase
	{
		public override RoleTypeId[] KillerRoles => new RoleTypeId[4]
		{
			RoleTypeId.ChaosConscript,
			RoleTypeId.ChaosMarauder,
			RoleTypeId.ChaosRepressor,
			RoleTypeId.ChaosRifleman
		};

		public override RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			if (Scp1509RespawnCriteriaBase.IsSkippableRole(victim))
			{
				return RoleTypeId.None;
			}
			return RoleTypeId.ChaosConscript;
		}
	}
}
