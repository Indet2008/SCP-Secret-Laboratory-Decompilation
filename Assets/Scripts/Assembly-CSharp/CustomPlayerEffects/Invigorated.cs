using PlayerRoles.FirstPersonControl;

namespace CustomPlayerEffects
{
	public class Invigorated : StatusEffectBase, IStaminaModifier
	{
		public override EffectClassification Classification => EffectClassification.Positive;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 0f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => false;
	}
}
