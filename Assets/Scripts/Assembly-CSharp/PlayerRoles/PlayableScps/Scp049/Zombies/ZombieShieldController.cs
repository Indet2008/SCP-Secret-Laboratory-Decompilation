using System.Collections.Generic;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HumeShield;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieShieldController : DynamicHumeShieldController
	{
		public const float MaxShield = 100f;

		public const float MaxActivateDistanceSqr = 100f;

		private static readonly HashSet<Scp049CallAbility> CallSubroutines = new HashSet<Scp049CallAbility>();

		private FirstPersonMovementModule _fpc;

		public override float HsMax => 100f;

		public override float HsRegeneration
		{
			get
			{
				if (!CallSubroutines.Any((Scp049CallAbility x) => x.IsMarkerShown && CheckDistanceTo(x.CastRole)))
				{
					return 0f;
				}
				return base.HsRegeneration;
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_fpc = (base.Owner.roleManager.CurrentRole as IFpcRole).FpcModule;
			if (NetworkServer.active)
			{
				base.HsCurrent = 0f;
			}
		}

		public override void OnHsValueChanged(float prevValue, float newValue)
		{
			if (NetworkServer.active && (prevValue != HsMax || newValue != 0f))
			{
				base.OnHsValueChanged(prevValue, newValue);
			}
		}

		private bool CheckDistanceTo(Scp049Role role)
		{
			return (role.FpcModule.Position - _fpc.Position).sqrMagnitude <= 100f;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += CallSubroutines.Clear;
			PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase oldRole, PlayerRoleBase newRole) =>
			{
				if (NetworkServer.active)
				{
					if (TryGetCallSubroutine(oldRole, out var sr))
					{
						CallSubroutines.Remove(sr);
					}
					if (TryGetCallSubroutine(newRole, out var sr2))
					{
						CallSubroutines.Add(sr2);
					}
				}
			};
		}

		private static bool TryGetCallSubroutine(PlayerRoleBase prb, out Scp049CallAbility sr)
		{
			if (prb is Scp049Role scp049Role)
			{
				return scp049Role.SubroutineModule.TryGetSubroutine<Scp049CallAbility>(out sr);
			}
			sr = null;
			return false;
		}
	}
}
