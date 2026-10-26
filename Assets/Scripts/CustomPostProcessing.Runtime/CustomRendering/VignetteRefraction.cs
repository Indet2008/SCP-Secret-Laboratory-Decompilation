using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Vignette Refraction")]
	public sealed class VignetteRefraction : MaterialEffect
	{
		public ColorParameter ColorStart = new ColorParameter(Color.clear);

		public ColorParameter ColorEnd = new ColorParameter(Color.clear);

		public TextureParameter RefractionTexture = new TextureParameter(null);

		public ClampedFloatParameter RefractionPower = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Frosting = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Fade = new ClampedFloatParameter(0.5f, 0.01f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/VignetteRefraction";

		public override bool IsActive()
		{
			return Intensity.value > 0f && RefractionTexture.value != null;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetTexture("_RefractionTex", RefractionTexture.value);
			material.SetVector("_Values", new Vector4(Intensity.value, RefractionPower.value, Frosting.value, Mathf.Max(Fade.value, 0.0001f)));
			material.SetColor("_Color1", ColorStart.value);
			material.SetColor("_Color2", ColorEnd.value);
		}
	}
}