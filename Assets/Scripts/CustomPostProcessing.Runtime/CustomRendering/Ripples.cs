using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Ripples")]
	public sealed class Ripples : MaterialEffect
	{
		public enum RipplesMode
		{
			Radial = 0,
			OmniDirectional = 1
		}

		[Serializable]
		public sealed class RipplesModeParam : VolumeParameter<RipplesMode>
		{
		}

		public RipplesModeParam Mode = new RipplesModeParam();

		public ClampedFloatParameter Strength = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter Distance = new ClampedFloatParameter(0f, 0f, 50f);

		public ClampedFloatParameter Speed = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter Width = new ClampedFloatParameter(1f, 0f, 10f);

		public ClampedFloatParameter Height = new ClampedFloatParameter(1f, 0f, 10f);

		protected override string EffectShaderName => "Hidden/Shader/Ripples";

		protected override int ShaderPass => (int)Mode.value;

		public override bool IsActive()
		{
			return Strength.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Strength", Strength.value * 0.01f);
			material.SetFloat("_Distance", Distance.value * 0.01f);
			material.SetFloat("_Speed", Speed.value);
			material.SetVector("_Size", new Vector2(Width.value, Height.value));
		}
	}
}
