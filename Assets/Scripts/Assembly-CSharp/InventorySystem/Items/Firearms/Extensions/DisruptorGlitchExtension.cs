using InventorySystem.Items.Firearms.Modules;

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
				if (_profileCopy == null)
				{
					_profileCopy = _postProcessVolume.profile;
				}
				_postProcessVolume.sharedProfile = _profileCopy;
				return _profileCopy;
			}
		}

		public void InitViewmodel(global::InventorySystem.Items.Firearms.AnimatedFirearmViewmodel viewmodel)
		{
			if (viewmodel.ParentFirearm.TryGetModules<MagazineModule, DisruptorAdsModule>(out _magModule, out _adsModule))
			{
				GlobalProfile.TryGet<global::CustomRendering.Glitch>(out _glitchVfx);
			}
		}

		private void LateUpdate()
		{
			GlitchSettings glitchSettings = (_adsModule.AdsTarget ? _adsGlichSettings : _hipGlitchSettings);
			if (!_ammoWeighted.HasValue)
			{
				_ammoWeighted = _magModule.GetAmmoStoredForSerial(_magModule.Firearm.ItemSerial);
			}
			_ammoWeighted = global::UnityEngine.Mathf.MoveTowards(_ammoWeighted.Value, _magModule.GetAmmoStoredForSerial(_magModule.Firearm.ItemSerial), global::UnityEngine.Time.deltaTime * _vfxAdjustSpeed);
			_glitchVfx.Amount.value = glitchSettings.AmountOverAmmo.Evaluate(_ammoWeighted.Value);
			_glitchVfx.Noise.value = glitchSettings.NoiseOverAmmo.Evaluate(_ammoWeighted.Value);
		}

		public DisruptorGlitchExtension()
		{
		}
	}
}
