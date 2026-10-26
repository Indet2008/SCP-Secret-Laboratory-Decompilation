using System;
using UnityEngine.Rendering;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Fade Effect")]
	public sealed class FadeEffect : DistanceEffect
	{
		protected override string ShaderName => "Hidden/Shader/FadeEffect";
	}
}