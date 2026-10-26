using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Grayscale")]
	public sealed class Grayscale : DistanceEffect
	{
		private static readonly int IntensityId = Shader.PropertyToID("_GrayScaleIntensity");

		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string ShaderName => "Hidden/Shader/Grayscale";

		protected override int ShaderPass => DistanceFade.value ? 1 : 0;

		public override bool IsActive()
		{
			return Intensity.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			base.SetProperties(material, camera);
			material.SetFloat(IntensityId, Intensity.value);
		}
	}
}