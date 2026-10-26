using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Darken")]
	public sealed class Darken : MaterialEffect
	{
		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Darken";

		public override bool IsActive()
		{
			return Intensity.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_DarknessIntensity", Intensity.value);
		}
	}
}