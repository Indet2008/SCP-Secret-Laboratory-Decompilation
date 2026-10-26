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
		public ClampedFloatParameter Strength = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter Distance = new ClampedFloatParameter(0f, 0f, 50f);

		public ClampedFloatParameter Speed = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter Width = new ClampedFloatParameter(1f, 0f, 10f);

		public ClampedFloatParameter Height = new ClampedFloatParameter(1f, 0f, 10f);

		protected override string EffectShaderName => "Hidden/Shader/Ripples";

		public override bool IsActive()
		{
			return Strength.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Strength", Strength.value);
			material.SetFloat("_Distance", Distance.value);
			material.SetFloat("_Speed", Speed.value);
			material.SetVector("_Size", new Vector2(Width.value, Height.value));
		}
	}
}