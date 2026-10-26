using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Custom Vignette")]
	public sealed class CustomVignette : MaterialEffect
	{
		public ClampedFloatParameter Size = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Fade = new ClampedFloatParameter(0f, 0f, 1f);

		public ColorParameter Color = new ColorParameter(UnityEngine.Color.clear);

		protected override string EffectShaderName => "Hidden/Shader/CustomVignette";

		public override bool IsActive()
		{
			return Size.value > 0f && Fade.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Fade", Fade.value);
			material.SetFloat("_Intensity", Size.value);
			material.SetColor("_Color", Color.value);
		}
	}
}