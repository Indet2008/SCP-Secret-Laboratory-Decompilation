using PlayerRoles.FirstPersonControl;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieVisibilityController : FpcVisibilityController
	{
		public override bool ValidateVisibility(ReferenceHub hub)
		{
			if (!base.ValidateVisibility(hub))
			{
				return hub.roleManager.CurrentRole is Scp049Role;
			}
			return true;
		}
	}
}
