using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Edge Detection")]
	public sealed class EdgeDetection : CustomPostProcessVolumeComponent, IPostProcessComponent
	{
		public BoolParameter Debug = new BoolParameter(false);

		public BoolParameter InvertFadeDistance = new BoolParameter(false);

		public BoolParameter DistanceFade = new BoolParameter(false);

		public FloatParameter StartFadeDistance = new FloatParameter(0f);

		public FloatParameter EndFadeDistance = new FloatParameter(0f);

		public ClampedFloatParameter SensitivityDepth = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter SensitivityNormals = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedFloatParameter LumThreshold = new ClampedFloatParameter(0f, 0f, 1f);

		public ColorParameter EdgeColor = new ColorParameter(Color.clear);

		public ClampedFloatParameter EdgeExp = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedIntParameter EdgeSize = new ClampedIntParameter(0, 0, 10);

		public ClampedFloatParameter EdgeOpacity = new ClampedFloatParameter(0f, 0f, 1f);

		public BoolParameter SobelThin = new BoolParameter(false);

		public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.BeforeTAA;

		public bool IsActive()
		{
			return false;
		}

		public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
		{
			HDUtils.BlitCameraTexture(cmd, source, destination);
		}
	}
}