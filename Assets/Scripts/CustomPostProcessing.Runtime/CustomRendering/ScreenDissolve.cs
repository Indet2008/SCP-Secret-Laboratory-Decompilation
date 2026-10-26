using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Screen Dissolve")]
	public sealed class ScreenDissolve : MaterialEffect
	{
		public ClampedFloatParameter DissolveAmount = new ClampedFloatParameter(0f, 0f, 1f);

		public TextureParameter BlendTexture = new TextureParameter(null);

		public TextureParameter OverlayTexture = new TextureParameter(null);

		protected override string EffectShaderName => "Hidden/Shader/ScreenDissolve";

		public override bool IsActive()
		{
			return DissolveAmount.value > 0f && BlendTexture.value != null;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_DissolveAmount", DissolveAmount.value);
			material.SetTexture("_BlendTex", BlendTexture.value);
			material.SetTexture("_OverlayTex", OverlayTexture.value != null ? OverlayTexture.value : Texture2D.blackTexture);
		}
	}
}