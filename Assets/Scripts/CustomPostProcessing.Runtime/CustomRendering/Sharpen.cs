using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Sharpen")]
	public sealed class Sharpen : MaterialEffect
	{
		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 5f);

		public ClampedFloatParameter Radius = new ClampedFloatParameter(1f, 0f, 5f);

		protected override string EffectShaderName => "Hidden/Shader/Sharpen";

		public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.BeforeTAA;

		public override bool IsActive()
		{
			return Amount.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Amount", Amount.value);
			material.SetFloat("_Radius", Radius.value);
		}
	}
}