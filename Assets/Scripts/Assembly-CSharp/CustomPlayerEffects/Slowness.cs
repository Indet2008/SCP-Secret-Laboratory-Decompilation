using PlayerRoles.FirstPersonControl;

namespace CustomPlayerEffects
{
	public class Slowness : StatusEffectBase, IMovementSpeedModifier, IStaminaModifier, ISpectatorDataPlayerEffect
	{
		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 1f - (float)(int)base.Intensity * 0.01f;

		public float MovementSpeedLimit => float.MaxValue;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public bool StaminaModifierActive => base.Intensity == 100;

		public bool SprintingDisabled => true;

		public bool GetSpectatorText(out string s)
		{
			s = $"{base.Intensity}% Slowness";
			return true;
		}
	}
}
