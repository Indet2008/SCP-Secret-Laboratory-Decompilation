using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public abstract class Scp1509RespawnCriteriaBase
	{
		public virtual RoleTypeId[] KillerRoles { get; }

		public abstract RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim);

		protected static bool IsSkippableRole(ReferenceHub victim)
		{
			PlayerRoleBase currentRole = victim.roleManager.CurrentRole;
			if (currentRole.Team != Team.SCPs)
			{
				return false;
			}
			RoleTypeId roleTypeId = currentRole.RoleTypeId;
			if (roleTypeId != RoleTypeId.Scp0492)
			{
				return roleTypeId != RoleTypeId.Scp939;
			}
			return false;
		}
	}
}
