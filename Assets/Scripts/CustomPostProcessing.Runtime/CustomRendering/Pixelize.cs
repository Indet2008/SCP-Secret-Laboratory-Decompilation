using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Pixelize")]
	public sealed class Pixelize : MaterialEffect
	{
		public FloatParameter Amount = new FloatParameter(0f);

		protected override string EffectShaderName => "Hidden/Shader/Pixelize";

		public override bool IsActive()
		{
			return Amount.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_Resolution", Amount.value / 10f);
		}
	}
}