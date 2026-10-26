using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Glitch")]
	public sealed class Glitch : MaterialEffect
	{
		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Noise = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Glitch";

		public override bool IsActive()
		{
			return Amount.value > 0f || Noise.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Glitch", Amount.value);
			material.SetFloat("_Noise", Noise.value);
		}
	}
}