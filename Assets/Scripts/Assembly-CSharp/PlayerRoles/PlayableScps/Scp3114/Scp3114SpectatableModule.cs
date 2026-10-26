using InventorySystem.Items;
using PlayerRoles.FirstPersonControl;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114SpectatableModule : FpcSpectatableModule
	{
		internal override void OnBeganSpectating()
		{
			base.OnBeganSpectating();
			if (base.MainRole is Scp3114Role { Disguised: not false } scp3114Role)
			{
				SharedHandsController.SetRoleGloves(scp3114Role.CurIdentity.StolenRole);
			}
		}
	}
}
