using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SilentWalk : StatusEffectBase, IFootstepEffect
	{
		private const float VolumePerStack = 0.1f;

		public override EffectClassification Classification => EffectClassification.Positive;

		public float ProcessFootstepOverrides(AnimatedCharacterModel _, float dis)
		{
			return Mathf.Max(1f - 0.1f * (float)(int)base.Intensity, 0f) * dis;
		}
	}
}
