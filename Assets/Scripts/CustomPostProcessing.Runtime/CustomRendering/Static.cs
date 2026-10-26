using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Static")]
	public sealed class Static : MaterialEffect
	{
		public ClampedFloatParameter Fade = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter FadeAdditive = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter FadeDistortion = new ClampedFloatParameter(0f, 0f, 1f);

		public TextureParameter StaticTexture = new TextureParameter(null);

		protected override string EffectShaderName => "Hidden/Shader/Static";

		public override bool IsActive()
		{
			return StaticTexture.value != null && (Fade.value > 0f || FadeAdditive.value > 0f || FadeDistortion.value > 0f);
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Fade", Fade.value);
			material.SetFloat("_FadeAdditive", FadeAdditive.value);
			material.SetFloat("_FadeDistortion", FadeDistortion.value);
			material.SetTexture("_StaticTex", StaticTexture.value);
		}
	}
}