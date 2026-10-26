using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaTutorial : Scp1509RespawnCriteriaBase
	{
		public override RoleTypeId[] KillerRoles => new RoleTypeId[1] { RoleTypeId.Tutorial };

		public override RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			return RoleTypeId.Tutorial;
		}
	}
}
