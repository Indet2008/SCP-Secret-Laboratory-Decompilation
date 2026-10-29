using PlayerRoles;

namespace OperationalGuide
{
	public class OperationalExistingPannablePage : OperationalPannablePage
	{
		public RoleTypeId RoleToSpawn;

		public override void SpawnPannable()
		{
			PannableObject = OperationalGuide.Instance.SpawnModelRoleForCamera(RoleToSpawn);
		}
	}
}
