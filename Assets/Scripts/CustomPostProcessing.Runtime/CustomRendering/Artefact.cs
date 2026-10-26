using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Artefact")]
	public sealed class Artefact : MaterialEffect
	{
		public ClampedFloatParameter Fade = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Colorization = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Parasite = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Noise = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Artefact";

		public override bool IsActive()
		{
			return Fade.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetVector("_Effects", new Vector4(Fade.value, Colorization.value, Parasite.value, Noise.value));
		}
	}
}