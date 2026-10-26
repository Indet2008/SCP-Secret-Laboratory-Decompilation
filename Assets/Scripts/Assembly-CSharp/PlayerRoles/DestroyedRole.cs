using UnityEngine;

namespace PlayerRoles
{
	public class DestroyedRole : PlayerRoleBase, IHiddenRole
	{
		public override RoleTypeId RoleTypeId => RoleTypeId.Destroyed;

		public override Color RoleColor => Color.white;

		public override Team Team => Team.Dead;

		public bool IsHidden => true;
	}
}
