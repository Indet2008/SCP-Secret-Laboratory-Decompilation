using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomPlayerEffects
{
	public class VignettePulse : PostProcessEffectPulse
	{
		private Vignette _effect;

		protected override float EffectValue
		{
			get
			{
				return _effect.intensity.value;
			}
			set
			{
				_effect.intensity.value = value;
			}
		}

		protected override void SetEffectType(VolumeProfile profile)
		{
			profile.TryGet<Vignette>(out _effect);
		}
	}
}
