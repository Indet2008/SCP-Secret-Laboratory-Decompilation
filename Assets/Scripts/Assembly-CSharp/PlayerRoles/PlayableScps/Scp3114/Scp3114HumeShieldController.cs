using PlayerRoles.PlayableScps.HumeShield;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114HumeShieldController : DynamicHumeShieldController
	{
		public override AudioClip ShieldBreakSound
		{
			get
			{
				if (!(base.Role as Scp3114Role).Disguised)
				{
					return base.ShieldBreakSound;
				}
				return null;
			}
		}
	}
}
