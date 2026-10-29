using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Blur Effect")]
	public sealed class BlurEffect : DistanceEffect
	{
		[Serializable]
		public sealed class BlurMethodParameter : VolumeParameter<BlurMethod>
		{
		}

		public enum BlurMethod
		{
			Gaussian = 0,
			Box = 1
		}

		private enum Pass
		{
			Blend = 0,
			DepthFade = 1,
			Gaussian = 2,
			Box = 3
		}

		private static readonly int BlurOffsetsId = Shader.PropertyToID("_BlurOffsets");

		private static readonly int BlurredTexId = Shader.PropertyToID("_BlurredTex");

		public BlurMethodParameter Mode = new BlurMethodParameter();

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
			_blur1 = AllocBuffer();
			_blur2 = AllocBuffer();
		}

		private static RTHandle AllocBuffer()
		{
			return RTHandles.Alloc(Vector2.one, 1, DepthBits.None, GraphicsFormat.R8G8B8A8_SRGB, FilterMode.Bilinear, TextureWrapMode.Repeat, TextureDimension.Tex2DArray, enableRandomWrite: false, useMipMap: false, autoGenerateMips: true, isShadowMap: false, anisoLevel: 1, mipMapBias: 0f, msaaSamples: MSAASamples.None, bindTextureMS: false, useDynamicScale: false, name: string.Empty);
		}

		public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
		{
			if (EffectMaterial == null || _blur1 == null)
			{
				HDUtils.BlitCameraTexture(cmd, source, destination);
				return;
			}
			if (Iterations.value > 12)
			{
				return;
			}
			HDUtils.BlitCameraTexture(cmd, source, _blur1, 0f, bilinear: true);
			int pass = (int)((Mode.value != BlurMethod.Gaussian) ? Pass.Box : Pass.Gaussian);
			float x = Amount.value / (float)source.referenceSize.x;
			float y = Amount.value / (float)source.referenceSize.y;
			for (int i = 0; i < Iterations.value; i++)
			{
				cmd.SetGlobalVector(BlurOffsetsId, new Vector4(x, 0f, 0f, 0f));
				Blitter.BlitCameraTexture(cmd, _blur1, _blur2, EffectMaterial, pass);
				cmd.SetGlobalVector(BlurOffsetsId, new Vector4(0f, y, 0f, 0f));
				Blitter.BlitCameraTexture(cmd, _blur2, _blur1, EffectMaterial, pass);
				if (HighQuality.value)
				{
					cmd.SetGlobalVector(BlurOffsetsId, new Vector4(x, 0f, 0f, 0f));
					HDUtils.BlitCameraTexture(cmd, _blur1, _blur2, EffectMaterial, pass);
					cmd.SetGlobalVector(BlurOffsetsId, new Vector4(0f, y, 0f, 0f));
					HDUtils.BlitCameraTexture(cmd, _blur2, _blur1, EffectMaterial, pass);
				}
			}
			EffectMaterial.SetTexture(BlurredTexId, _blur1);
			CustomPostProcessUtils.SetCommonProperties(EffectMaterial, camera, source);
			if (DistanceFade.value && FadeIntensity.value > 0f)
			{
				SetDistanceProperties(camera);
				HDUtils.DrawFullScreen(cmd, EffectMaterial, destination, null, (int)Pass.DepthFade);
			}
			else
			{
				HDUtils.DrawFullScreen(cmd, EffectMaterial, destination, null, (int)Pass.Blend);
			}
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
