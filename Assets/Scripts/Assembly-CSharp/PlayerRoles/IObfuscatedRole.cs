namespace PlayerRoles
{
	public interface IObfuscatedRole
	{
		RoleTypeId GetRoleForUser(ReferenceHub receiver);
	}
}
