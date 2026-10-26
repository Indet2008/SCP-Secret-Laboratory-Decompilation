using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Camera Shake")]
	public sealed class CameraShake : MaterialEffect
	{
		public ClampedFloatParameter ScanLineJitter = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter VerticalJump = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter HorizontalShake = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter ColorDrift = new ClampedFloatParameter(0f, 0f, 1f);

		private float _verticalJumpTime;

		protected override string EffectShaderName => "Hidden/Shader/CameraShake";

		public override bool IsActive()
		{
			return ScanLineJitter.value > 0f || VerticalJump.value > 0f || HorizontalShake.value > 0f || ColorDrift.value > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			_verticalJumpTime += Time.deltaTime * VerticalJump.value * 11.3f;
			float jitterThreshold = Mathf.Clamp01(1f - ScanLineJitter.value * 1.2f);
			float jitterDisplacement = 0.002f + Mathf.Pow(ScanLineJitter.value, 3f) * 0.05f;
			material.SetVector("_JitterJump", new Vector4(jitterDisplacement, jitterThreshold, VerticalJump.value, _verticalJumpTime));
			material.SetVector("_ColorShake", new Vector4(HorizontalShake.value * 0.2f, ColorDrift.value * 0.04f, Time.time * 606.11f, 0f));
		}
	}
}