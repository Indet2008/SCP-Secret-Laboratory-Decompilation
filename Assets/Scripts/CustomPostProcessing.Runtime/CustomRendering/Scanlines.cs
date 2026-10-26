using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Scanlines")]
	public sealed class Scanlines : MaterialEffect
	{
		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 2048f);

		public ClampedFloatParameter Speed = new ClampedFloatParameter(0f, 0f, 10f);

		protected override string EffectShaderName => "Hidden/Shader/Scanlines";

		public override bool IsActive()
		{
			return Intensity.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetVector("_Params", new Vector4(Intensity.value, Amount.value, Speed.value, 0f));
		}
	}
}