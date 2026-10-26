using AudioPooling;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Stained : StatusEffectBase, IStaminaModifier, IMovementSpeedModifier, IFootstepEffect
	{
		[SerializeField]
		private AudioClip[] _stainedFootsteps;

		[SerializeField]
		private float _originalLoudness;

		private const float SpeedMultiplier = 0.8f;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 0.8f;

		public float MovementSpeedLimit => float.MaxValue;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 1f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => true;

		public float ProcessFootstepOverrides(AnimatedCharacterModel _, float dis)
		{
			SilentWalk effect = base.Hub.playerEffectsController.GetEffect<SilentWalk>();
			if (effect.IsEnabled)
			{
				return effect.ProcessFootstepOverrides(_, dis);
			}
			AudioSourcePoolManager.PlayOnTransform(_stainedFootsteps.RandomItem(), base.transform, dis);
			return _originalLoudness;
		}
	}
}
