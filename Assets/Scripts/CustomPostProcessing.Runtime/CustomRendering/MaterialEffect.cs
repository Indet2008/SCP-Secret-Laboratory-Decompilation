using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	public abstract class MaterialEffect : CustomPostProcessVolumeComponent, IPostProcessComponent
	{
		protected Material EffectMaterial;

		protected abstract string EffectShaderName { get; }

		protected virtual int ShaderPass => 0;

		public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

		public abstract bool IsActive();

		public override void Setup()
		{
			EffectMaterial = CustomPostProcessUtils.CreateMaterial(EffectShaderName);
		}

		public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
		{
			if (EffectMaterial == null)
			{
				HDUtils.BlitCameraTexture(cmd, source, destination);
				return;
			}
			CustomPostProcessUtils.SetCommonProperties(EffectMaterial, camera, source);
			SetProperties(EffectMaterial, camera);
			HDUtils.DrawFullScreen(cmd, EffectMaterial, destination, null, ShaderPass);
		}

		protected abstract void SetProperties(Material material, HDCamera camera);

		public override void Cleanup()
		{
			CoreUtils.Destroy(EffectMaterial);
		}
	}
}
