using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomPlayerEffects
{
	public class VignetteSmoothnessPulse : PostProcessEffectPulse
	{
		private Vignette _effect;

		protected override float EffectValue
		{
			get
			{
				return _effect.smoothness.value;
			}
			set
			{
				_effect.smoothness.value = value;
			}
		}

		protected override void SetEffectType(VolumeProfile profile)
		{
			profile.TryGet<Vignette>(out _effect);
		}
	}
}
