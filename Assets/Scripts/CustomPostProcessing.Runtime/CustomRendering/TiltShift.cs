using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Tilt Shift")]
	public sealed class TiltShift : CustomPostProcessVolumeComponent, IPostProcessComponent
	{
		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter AreaSize = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter AreaFalloff = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Offset = new ClampedFloatParameter(0f, -1f, 1f);

		public ClampedFloatParameter Angle = new ClampedFloatParameter(0f, 0f, 360f);

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