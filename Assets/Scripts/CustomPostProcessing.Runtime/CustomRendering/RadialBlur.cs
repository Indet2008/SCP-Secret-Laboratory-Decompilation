using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Radial Blur")]
	public sealed class RadialBlur : MaterialEffect
	{
		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedIntParameter Iterations = new ClampedIntParameter(6, 1, 12);

		protected override string EffectShaderName => "Hidden/Shader/Radial Blur";

		public override bool IsActive()
		{
			return Amount.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Amount", Amount.value / 50f);
			material.SetFloat("_Iterations", Iterations.value);
		}
	}
}