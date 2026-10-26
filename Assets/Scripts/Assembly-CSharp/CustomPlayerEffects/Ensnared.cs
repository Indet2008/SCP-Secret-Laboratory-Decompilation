using PlayerRoles.FirstPersonControl;

namespace CustomPlayerEffects
{
	public class Ensnared : StatusEffectBase, IMovementSpeedModifier, IStaminaModifier
	{
		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 0f;

		public float MovementSpeedLimit => 0f;

		public bool StaminaModifierActive => base.IsEnabled;

		public bool SprintingDisabled => true;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);
	}
}
