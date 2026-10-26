using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Fog Effect")]
	public sealed class FogEffect : DistanceEffect
	{
		private static readonly int FogColorId = Shader.PropertyToID("_CustomFogColor");

		public ColorParameter FogColor = new ColorParameter(Color.clear);

		protected override string ShaderName => "Hidden/Shader/FogEffect";

		public override bool IsActive()
		{
			return base.IsActive() && FogColor.value.a > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			base.SetProperties(material, camera);
			material.SetColor(FogColorId, FogColor.value);
		}
	}
}