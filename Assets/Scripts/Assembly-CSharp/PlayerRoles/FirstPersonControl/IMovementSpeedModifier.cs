namespace PlayerRoles.FirstPersonControl
{
	public interface IMovementSpeedModifier
	{
		bool MovementModifierActive { get; }

		float MovementSpeedMultiplier { get; }

		float MovementSpeedLimit { get; }
	}
}
