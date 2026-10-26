using PlayerRoles.PlayableScps.Scp049;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507Indicators : RagdollIndicatorsBase<Scp1507Role>
	{
		protected override GameObject GenerateIndicator(BasicRagdoll ragdoll)
		{
			GameObject obj = base.GenerateIndicator(ragdoll);
			if (obj.TryGetComponent<Scp1507CorpseIndicator>(out var component))
			{
				component.Ragdoll = ragdoll as Scp1507Ragdoll;
			}
			return obj;
		}

		protected override bool ValidateRagdoll(BasicRagdoll basicRagdoll)
		{
			if (basicRagdoll is Scp1507Ragdoll scp1507Ragdoll)
			{
				return scp1507Ragdoll.ValidateRevive(base.Owner);
			}
			return false;
		}
	}
}
