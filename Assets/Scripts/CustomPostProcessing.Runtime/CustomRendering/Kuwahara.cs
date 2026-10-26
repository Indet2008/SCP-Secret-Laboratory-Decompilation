using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Kuwahara")]
	public sealed class Kuwahara : CustomPostProcessVolumeComponent, IPostProcessComponent
	{
		public ClampedIntParameter Radius = new ClampedIntParameter(0, 0, 20);

		public FloatParameter StartFadeDistance = new FloatParameter(0f);

		public FloatParameter EndFadeDistance = new FloatParameter(0f);

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