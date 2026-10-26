using PlayerRoles.FirstPersonControl;

namespace CustomPlayerEffects
{
	public class MovementBoost : StatusEffectBase, IMovementSpeedModifier, ISpectatorDataPlayerEffect
	{
		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => (100f + (float)(int)base.Intensity) / 100f;

		public float MovementSpeedLimit => float.MaxValue;

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool GetSpectatorText(out string s)
		{
			s = $"+{base.Intensity}% Movement Boost";
			return true;
		}
	}
}
