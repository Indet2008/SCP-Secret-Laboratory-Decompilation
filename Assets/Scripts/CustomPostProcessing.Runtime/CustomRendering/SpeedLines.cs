using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Speed Lines")]
	public sealed class SpeedLines : MaterialEffect
	{
		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		public TextureParameter NoiseTex = new TextureParameter(null);

		public ClampedFloatParameter Size = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Falloff = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/SpeedLines";

		public override bool IsActive()
		{
			return Intensity.value > 0f && NoiseTex.value != null;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetTexture("_NoiseTex", NoiseTex.value);
			material.SetVector("_Params", new Vector4(Intensity.value, Falloff.value * 14f + 2f, Size.value * 2f, 0f));
		}
	}
}