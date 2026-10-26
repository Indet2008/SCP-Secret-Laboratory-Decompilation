using PlayerRoles.FirstPersonControl;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939StateProcessor : FpcStateProcessor
	{
		public Scp939StateProcessor(ReferenceHub hub, FirstPersonMovementModule fpmm, float useRate, float regenCooldown, float regenRate, float rampupTime)
			: base(hub, fpmm, useRate, FpcStateProcessor.DefaultSpawnImmunity, regenCooldown, regenRate, rampupTime)
		{
		}

		public override void ClientUpdateInput(FirstPersonMovementModule moduleRef, float walkSpeed, out PlayerMovementState valueToSend)
		{
			base.ClientUpdateInput(moduleRef, walkSpeed, out valueToSend);
			Scp939Motor scp939Motor = moduleRef.Motor as Scp939Motor;
			if (valueToSend == PlayerMovementState.Sprinting && !scp939Motor.MovingForwards)
			{
				valueToSend = PlayerMovementState.Walking;
			}
		}
	}
}
