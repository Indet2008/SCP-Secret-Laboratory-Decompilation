using System.Collections.Generic;
using InventorySystem.Items.Firearms.Extensions;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.SwayControllers;

namespace InventorySystem.Items.Firearms
{
	public class FirearmSway : WalkSway
	{
		private readonly bool _supportsAds;

		private readonly ViewmodelAdsExtension _adsExtension;

		private readonly AnimatedFirearmViewmodel _viewmodel;

		private readonly Firearm _firearm;

		private readonly IAdsModule _adsModule;

		private readonly List<ISwayModifierModule> _swayModifiers;

		private float _bobScale;

		private float _jumpScale;

		private float _walkScale;

		protected override GoopSwaySettings Settings
		{
			get
			{
				if (!_supportsAds || !_adsModule.AdsTarget)
				{
					return base.Settings;
				}
				return _adsExtension.AdsSway;
			}
		}

		protected override float OverallBobMultiplier => base.OverallBobMultiplier * _bobScale;

		protected override float JumpSwayWeightMultiplier => base.JumpSwayWeightMultiplier * _jumpScale;

		protected override float WalkSwayWeightMultiplier => base.WalkSwayWeightMultiplier * _walkScale;

		public FirearmSway(GoopSwaySettings hipSettings, AnimatedFirearmViewmodel vm)
			: base(hipSettings, vm)
		{
			_viewmodel = vm;
			_firearm = vm.ParentFirearm;
			_supportsAds = TryInitAds(out _adsExtension, out _adsModule);
			_swayModifiers = new List<ISwayModifierModule>();
			ModuleBase[] modules = _firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is ISwayModifierModule item)
				{
					_swayModifiers.Add(item);
				}
			}
		}

		private bool TryInitAds(out ViewmodelAdsExtension extension, out IAdsModule module)
		{
			bool num = _viewmodel.TryGetExtension<ViewmodelAdsExtension>(out extension);
			bool flag = _firearm.TryGetModule<IAdsModule>(out module);
			return num & flag;
		}

		public override void UpdateSway()
		{
			base.UpdateSway();
			_bobScale = 1f;
			_jumpScale = 1f;
			_walkScale = 1f;
			foreach (ISwayModifierModule swayModifier in _swayModifiers)
			{
				_bobScale *= swayModifier.BobbingSwayScale;
				_jumpScale *= swayModifier.JumpSwayScale;
				_walkScale *= swayModifier.WalkSwayScale;
			}
		}
	}
}
