using CustomRendering;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	public class VignetteRefractionPulse : PostProcessEffectPulse
	{
		private VignetteRefraction _effect;

		protected override float EffectValue
		{
			get
			{
				return _effect.RefractionPower.value;
			}
			set
			{
				_effect.RefractionPower.value = value;
			}
		}

		protected override void SetEffectType(VolumeProfile profile)
		{
			profile.TryGet<VignetteRefraction>(out _effect);
		}
	}
}
