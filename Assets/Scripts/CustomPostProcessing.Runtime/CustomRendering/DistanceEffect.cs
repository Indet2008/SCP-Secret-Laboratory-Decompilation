using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	public abstract class DistanceEffect : MaterialEffect
	{
		public BoolParameter DistanceFade = new BoolParameter(false);

		public ClampedFloatParameter FadeIntensity = new ClampedFloatParameter(0f, 0f, 1f);

		public FloatParameter EndDistance = new FloatParameter(0f);

		public FloatParameter StartDistance = new FloatParameter(0f);

		public ClampedFloatParameter CoverSkybox = new ClampedFloatParameter(0f, 0f, 1f);

		protected override string EffectShaderName => ShaderName;

		protected abstract string ShaderName { get; }

		public bool DistanceFadeIsActive()
		{
			return DistanceFade.value;
		}

		public override bool IsActive()
		{
			return FadeIntensity.value > 0f;
		}

		public void SetDistanceProperties(HDCamera camera)
		{
			if (EffectMaterial != null)
			{
				CustomPostProcessUtils.SetDistanceParams(EffectMaterial, DistanceFade.value, StartDistance.value, EndDistance.value, FadeIntensity.value, CoverSkybox.value);
			}
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			SetDistanceProperties(camera);
		}
	}
}