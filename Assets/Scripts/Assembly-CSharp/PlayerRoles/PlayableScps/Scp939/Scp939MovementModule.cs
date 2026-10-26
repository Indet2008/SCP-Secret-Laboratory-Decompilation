using PlayerRoles.FirstPersonControl;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939MovementModule : FirstPersonMovementModule
	{
		private const float StaminaUseRate = 0.09f;

		private const float StaminaRegenRate = 0.1f;

		private const float StaminaRegenCooldown = 5f;

		private const float StaminaRampupTime = 0.1f;

		protected override FpcMotor NewMotor => new Scp939Motor(base.Hub, base.Role as Scp939Role, FallDamageSettings);

		protected override FpcMouseLook NewMouseLook => new Scp939MouseLook(base.Hub, this);

		protected override FpcStateProcessor NewStateProcessor => new Scp939StateProcessor(base.Hub, this, 0.09f, 5f, 0.1f, 0.1f);

		protected override PlayerMovementState ValidateMovementState(PlayerMovementState state)
		{
			state = base.ValidateMovementState(state);
			Scp939Motor scp939Motor = base.Motor as Scp939Motor;
			if (state == PlayerMovementState.Sprinting && !scp939Motor.MovingForwards)
			{
				state = PlayerMovementState.Walking;
			}
			return state;
		}
	}
}
