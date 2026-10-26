using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Overlay")]
	public sealed class Overlay : MaterialEffect
	{
		public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

		public TextureParameter OverlayTex = new TextureParameter(null);

		public BoolParameter autoAspect = new BoolParameter(false);

		public ClampedFloatParameter Tiling = new ClampedFloatParameter(1f, 0f, 100f);

		protected override string EffectShaderName => "Hidden/Shader/Overlay";

		public override bool IsActive()
		{
			return Intensity.value > 0f && OverlayTex.value != null;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetTexture("_OverlayTex", OverlayTex.value);
			material.SetVector("_Params", new Vector4(Intensity.value, Tiling.value, autoAspect.value ? 1f : 0f, 0f));
		}
	}
}