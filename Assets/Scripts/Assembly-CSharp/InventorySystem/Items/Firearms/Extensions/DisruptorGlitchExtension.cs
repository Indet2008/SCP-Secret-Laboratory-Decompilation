namespace InventorySystem.Items.Firearms.Extensions
{
	public class DisruptorGlitchExtension : global::UnityEngine.MonoBehaviour, global::InventorySystem.Items.Firearms.Extensions.IViewmodelExtension
	{
		[global::System.Serializable]
		private struct GlitchSettings
		{
			public global::UnityEngine.AnimationCurve AmountOverAmmo;

			public global::UnityEngine.AnimationCurve NoiseOverAmmo;
		}

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.Volume _postProcessVolume;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Items.Firearms.Extensions.DisruptorGlitchExtension.GlitchSettings _hipGlitchSettings;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Items.Firearms.Extensions.DisruptorGlitchExtension.GlitchSettings _adsGlichSettings;

		[global::UnityEngine.SerializeField]
		private float _vfxAdjustSpeed;

		private global::InventorySystem.Items.Firearms.Modules.MagazineModule _magModule;

		private global::InventorySystem.Items.Firearms.Modules.DisruptorAdsModule _adsModule;

		private global::CustomRendering.Glitch _glitchVfx;

		private float? _ammoWeighted;

		private static global::UnityEngine.Rendering.VolumeProfile _profileCopy;

		private global::UnityEngine.Rendering.VolumeProfile GlobalProfile
		{
			get
			{
				return default;
			}
		}

		public void InitViewmodel(global::InventorySystem.Items.Firearms.AnimatedFirearmViewmodel viewmodel)
		{
		}

		private void LateUpdate()
		{
		}

		public DisruptorGlitchExtension()
		{
		}
	}
}
