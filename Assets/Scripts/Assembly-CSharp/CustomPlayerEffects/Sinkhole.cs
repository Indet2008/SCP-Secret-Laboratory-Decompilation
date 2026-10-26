using AudioPooling;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Sinkhole : StatusEffectBase, IStaminaModifier, IMovementSpeedModifier, IFootstepEffect
	{
		[SerializeField]
		[Range(0f, 100f)]
		private float _slowAmount;

		[SerializeField]
		private AudioClip[] _footstepSounds;

		[SerializeField]
		private float _originalLoudness;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 1f - _slowAmount * 0.01f;

		public float MovementSpeedLimit => float.MaxValue;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 1f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => true;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public float ProcessFootstepOverrides(AnimatedCharacterModel _, float dis)
		{
			AudioSourcePoolManager.PlayOnTransform(_footstepSounds.RandomItem(), base.transform, dis);
			return _originalLoudness;
		}
	}
}
