using UnityEngine;

namespace DeathAnimations
{
	public class DissolveAnimation : DeathAnimation
	{
		private static readonly int StoneIntensityId = Shader.PropertyToID("_DissolveAmount");

		private static readonly int GlossId = Shader.PropertyToID("_GlossMapScale");

		[Range(0f, 1f)]
		public float StoneIntensity;

		private Renderer _renderer;

		private MaterialPropertyBlock _materialPropertyBlock;

		private float _glossStartValue;

		protected override void OnAnimationStarted()
		{
			base.enabled = true;
			_renderer = GetComponent<Renderer>();
			_materialPropertyBlock = new MaterialPropertyBlock();
			_renderer.GetPropertyBlock(_materialPropertyBlock);
			_glossStartValue = _materialPropertyBlock.GetFloat(GlossId);
		}

		private void Update()
		{
			_materialPropertyBlock.SetFloat(StoneIntensityId, StoneIntensity);
			_materialPropertyBlock.SetFloat(GlossId, Mathf.Lerp(_glossStartValue, 0f, StoneIntensity));
			_renderer.SetPropertyBlock(_materialPropertyBlock);
			if (!(StoneIntensity < 1f))
			{
				Object.Destroy(this);
			}
		}
	}
}
