using MapGeneration.Holidays;

namespace PlayerRoles
{
	public class RoleVariantsModule : VariantsModuleBase<PlayerRoleBase>
	{
		private void Reset()
		{
			PlayerRoleBase componentInParent = GetComponentInParent<PlayerRoleBase>();
			if (!(componentInParent == null))
			{
				componentInParent.VariantsModule = this;
			}
		}
	}
}
