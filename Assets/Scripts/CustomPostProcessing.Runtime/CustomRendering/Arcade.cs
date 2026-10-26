using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Arcade")]
	public sealed class Arcade : MaterialEffect
	{
		public ClampedFloatParameter Fade = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => "Hidden/Shader/Arcade";

		public override bool IsActive()
		{
			return Fade.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Fade", Fade.value);
		}
	}
}