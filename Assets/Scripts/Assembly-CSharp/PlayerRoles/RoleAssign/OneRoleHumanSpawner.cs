namespace PlayerRoles.RoleAssign
{
	public class OneRoleHumanSpawner : IHumanSpawnHandler
	{
		public RoleTypeId NextRole { get; }

		public OneRoleHumanSpawner(RoleTypeId targetRole)
		{
			NextRole = targetRole;
		}
	}
}
