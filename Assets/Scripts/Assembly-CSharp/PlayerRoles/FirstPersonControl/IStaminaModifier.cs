namespace PlayerRoles.FirstPersonControl
{
	public interface IStaminaModifier
	{
		bool StaminaModifierActive { get; }

		float StaminaUsageMultiplier => 1f;

		float StaminaRegenMultiplier => 1f;

		bool SprintingDisabled => false;

		bool ForceSprinting => false;
	}
}
