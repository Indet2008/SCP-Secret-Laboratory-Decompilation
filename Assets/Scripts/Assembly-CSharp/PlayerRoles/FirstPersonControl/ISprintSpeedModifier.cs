namespace PlayerRoles.FirstPersonControl
{
	public interface ISprintSpeedModifier
	{
		bool SprintModifierActive { get; }

		float SprintSpeedMultiplier { get; }
	}
}
