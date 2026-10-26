using PlayerRoles.FirstPersonControl;

namespace CustomPlayerEffects
{
	public class Disabled : StatusEffectBase, IMovementSpeedModifier
	{
		public float SpeedMultiplier = 0.8f;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => (SpeedMultiplier - 1f) * RainbowTaste.CurrentMultiplier(base.Hub) + 1f;

		public float MovementSpeedLimit => float.MaxValue;
	}
}
