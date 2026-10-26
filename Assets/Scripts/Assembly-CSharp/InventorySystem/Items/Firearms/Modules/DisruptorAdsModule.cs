using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class DisruptorAdsModule : LinearAdsModule, ILightEmittingItem
	{
		private const float NightVisionThreshold = 0.6f;

		private DisruptorActionModule _disruptorAction;

		private bool _preventAds;

		[SerializeField]
		private float _zoomAmount;

		[SerializeField]
		private float _sensitivtyScale;

		[SerializeField]
		private float _inaccuracyScale;

		protected override bool AllowAds
		{
			get
			{
				if (base.AllowAds && !_disruptorAction.IsReloading)
				{
					return !_preventAds;
				}
				return false;
			}
		}

		public override float BaseZoomAmount => _zoomAmount;

		public override float AdditionalSensitivityModifier => _sensitivtyScale;

		public override float BaseAdsInaccuracy => base.BaseAdsInaccuracy * _inaccuracyScale;

		public override float BaseHipInaccuracy => base.BaseHipInaccuracy * _inaccuracyScale;

		public bool IsEmittingLight => base.AdsAmount > 0.6f;

		protected override void OnInit()
		{
			base.OnInit();
			base.Firearm.TryGetModule<DisruptorActionModule>(out _disruptorAction);
		}

		[ExposedFirearmEvent]
		public void ForceExitAds()
		{
			_preventAds = true;
		}
	}
}
