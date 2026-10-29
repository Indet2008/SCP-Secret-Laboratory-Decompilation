using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/DoubleVision")]
	public sealed class DoubleVision : MaterialEffect
	{
		public enum ModeType
		{
			FullScreen = 0,
			Edges = 1
		}

		[Serializable]
		public sealed class DoubleVisionMode : VolumeParameter<ModeType>
		{
		}

		public DoubleVisionMode Mode = new DoubleVisionMode();

		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/DoubleVision";

		protected override int ShaderPass => (int)Mode.value;

		public override bool IsActive()
		{
			return Intensity.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Amount", Intensity.value * 0.1f);
		}
	}
}
