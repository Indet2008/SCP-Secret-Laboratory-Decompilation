using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Refraction")]
	public sealed class Refraction : MaterialEffect
	{
		public TextureParameter RefractionTex = new TextureParameter(null);

		public BoolParameter ConvertNormalMap = new BoolParameter(false);

		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Refraction";

		protected override int ShaderPass => ConvertNormalMap.value ? 1 : 0;

		public override bool IsActive()
		{
			return Amount.value > 0f && RefractionTex.value != null;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Amount", Amount.value);
			material.SetTexture("_RefractionTex", RefractionTex.value);
		}
	}
}