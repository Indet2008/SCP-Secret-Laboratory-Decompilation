using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Lighten")]
	public sealed class Lighten : MaterialEffect
	{
		public ClampedFloatParameter Brightness = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Opacity = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Lighten";

		public override bool IsActive()
		{
			return Opacity.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Opacity", Opacity.value);
			material.SetFloat("_Brightness", Brightness.value);
		}
	}
}