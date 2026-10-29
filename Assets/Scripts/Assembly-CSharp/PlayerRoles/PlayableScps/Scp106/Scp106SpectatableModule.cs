using CameraShaking;
using PlayerRoles.FirstPersonControl;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106SpectatableModule : FpcSpectatableModule
	{
		// Client-only in the original: spectators get the same submerge camera as the SCP-106 player.
		internal override void OnBeganSpectating()
		{
			base.OnBeganSpectating();
			if (base.MainRole is Scp106Role scp106Role && scp106Role.FpcModule.CharacterModelInstance is Scp106Model model)
			{
				CameraShakeController.AddEffect(new Scp106PortalShake(scp106Role, model));
			}
		}
	}
}
