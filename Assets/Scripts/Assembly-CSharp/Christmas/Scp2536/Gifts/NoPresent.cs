using PlayerRoles.PlayableScps.Scp096;

namespace Christmas.Scp2536.Gifts
{
	public class NoPresent : Scp2536AnomalousGiftBase
	{
		private const float EffectDuration = 15f;

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (base.CanBeGranted(hub))
			{
				return hub.roleManager.CurrentRole is Scp096Role;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			if (hub.roleManager.CurrentRole is Scp096Role scp096Role && scp096Role.SubroutineModule.TryGetSubroutine<Scp096RageCycleAbility>(out var subroutine))
			{
				subroutine.ServerTryEnableInput(15f);
			}
		}
	}
}
