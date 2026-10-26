using PlayerRoles.PlayableScps.Scp049;
using PlayerRoles.Ragdolls;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Indicators : RagdollIndicatorsBase<Scp3114Role>
	{
		protected override bool ValidateRagdoll(BasicRagdoll ragdoll)
		{
			if (!base.CastRole.Disguised && ragdoll.Info.RoleType.TryGetRoleTemplate<HumanRole>(out var _))
			{
				return !(ragdoll.Info.Handler is Scp3114DamageHandler scp3114DamageHandler) || scp3114DamageHandler.Subtype != Scp3114DamageHandler.HandlerType.SkinSteal;
			}
			return false;
		}
	}
}
