using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps;
using PlayerRoles.PlayableScps.Scp1507;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class Scp2536Projectile : FlybyDetectorProjectile
	{
		public override void ServerProcessHit(HitboxIdentity hid)
		{
			base.ServerProcessHit(hid);
			ReferenceHub targetHub = hid.TargetHub;
			if (!(targetHub.roleManager.CurrentRole is HumanRole humanRole))
			{
				return;
			}
			FpcStandardScp fpcStandardScp = null;
			Vector3 position = humanRole.FpcModule.Position;
			float num = float.MaxValue;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is FpcStandardScp fpcStandardScp2 && !(fpcStandardScp2 is Scp1507Role { Team: not Team.SCPs }))
				{
					float sqrMagnitude = (fpcStandardScp2.FpcModule.Position - position).sqrMagnitude;
					if (!(sqrMagnitude > num))
					{
						fpcStandardScp = fpcStandardScp2;
						num = sqrMagnitude;
					}
				}
			}
			if (!(fpcStandardScp == null))
			{
				targetHub.TryOverridePosition(fpcStandardScp.FpcModule.Position);
				targetHub.TryOverrideRotation(Vector3.zero);
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
