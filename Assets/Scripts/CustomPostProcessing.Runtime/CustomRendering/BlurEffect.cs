using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Blur")]
	public sealed class BlurEffect : DistanceEffect
	{
		private static readonly int BlurOffsetsId = Shader.PropertyToID("_BlurOffsets");

		private static readonly int BlurredTexId = Shader.PropertyToID("_BlurredTex");

		private const int BlendPass = 0;

		private const int DepthBlendPass = 1;

		private const int GaussianPass = 2;

		private const int BoxPass = 3;

		public BoolParameter HighQuality = new BoolParameter(false);

		public ClampedFloatParameter Amount = new ClampedFloatParameter(0f, 0f, 10f);

		public ClampedIntParameter Iterations = new ClampedIntParameter(1, 1, 10);

		private RTHandle _blur1;

		private RTHandle _blur2;

		protected override string ShaderName => "Hidden/Shader/BlurEffect";

		public override bool IsActive()
		{
			return Amount.value > 0f;
		}

		public override void Setup()
		{
			base.Setup();
			_blur1 = RTHandles.Alloc(Vector2.one * 0.5f, TextureXR.slices, dimension: TextureXR.dimension, colorFormat: GraphicsFormat.B10G11R11_UFloatPack32, useDynamicScale: true, name: "BlurEffect A");
			_blur2 = RTHandles.Alloc(Vector2.one * 0.5f, TextureXR.slices, dimension: TextureXR.dimension, colorFormat: GraphicsFormat.B10G11R11_UFloatPack32, useDynamicScale: true, name: "BlurEffect B");
		}

		public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
		{
			if (EffectMaterial == null || _blur1 == null)
			{
				HDUtils.BlitCameraTexture(cmd, source, destination);
				return;
			}
			CustomPostProcessUtils.SetCommonProperties(EffectMaterial, camera, source);
			float width = Mathf.Max(1f, camera.actualWidth * 0.5f);
			float height = Mathf.Max(1f, camera.actualHeight * 0.5f);
			float amount = Amount.value;
			EffectMaterial.SetVector(BlurOffsetsId, new Vector4(amount / width, amount / height, 0f, 0f));
			Blitter.BlitCameraTexture(cmd, source, _blur1, EffectMaterial, BoxPass);
			int iterations = Mathf.Max(1, Iterations.value);
			for (int i = 0; i < iterations; i++)
			{
				float spread = amount * 0.5f;
				if (HighQuality.value)
				{
					EffectMaterial.SetVector(BlurOffsetsId, new Vector4(spread / width, 0f, 0f, 0f));
					Blitter.BlitCameraTexture(cmd, _blur1, _blur2, EffectMaterial, GaussianPass);
					EffectMaterial.SetVector(BlurOffsetsId, new Vector4(0f, spread / height, 0f, 0f));
					Blitter.BlitCameraTexture(cmd, _blur2, _blur1, EffectMaterial, GaussianPass);
				}
				else
				{
					EffectMaterial.SetVector(BlurOffsetsId, new Vector4(spread / width, spread / height, 0f, 0f));
					Blitter.BlitCameraTexture(cmd, _blur1, _blur2, EffectMaterial, BoxPass);
					Blitter.BlitCameraTexture(cmd, _blur2, _blur1, EffectMaterial, BoxPass);
				}
			}
			SetDistanceProperties(camera);
			EffectMaterial.SetTexture(BlurredTexId, _blur1);
			CustomPostProcessUtils.SetCommonProperties(EffectMaterial, camera, source);
			HDUtils.DrawFullScreen(cmd, EffectMaterial, destination, null, DistanceFade.value ? DepthBlendPass : BlendPass);
		}

		public override void Cleanup()
		{
			base.Cleanup();
			RTHandles.Release(_blur1);
			RTHandles.Release(_blur2);
			_blur1 = null;
			_blur2 = null;
		}
	}
}