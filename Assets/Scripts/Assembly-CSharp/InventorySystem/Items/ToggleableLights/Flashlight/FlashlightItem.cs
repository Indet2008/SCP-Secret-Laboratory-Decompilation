using System;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Flashlight
{
	public class FlashlightItem : ToggleableLightItemBase
	{
		private Light _lightSource;

		private static FlashlightItem _cachedFlashlight;

		private static bool _cacheSet;

		public override float Weight => 0.7f;

		public static FlashlightItem Template
		{
			get
			{
				if (_cacheSet)
				{
					return _cachedFlashlight;
				}
				if (!InventoryItemLoader.TryGetItem<FlashlightItem>(ItemType.Flashlight, out var result))
				{
					throw new InvalidOperationException($"Item {ItemType.Flashlight} is not defined!");
				}
				_cachedFlashlight = result;
				_cacheSet = true;
				return result;
			}
		}

		protected override void SetLightSourceStatus(bool value)
		{
			_lightSource.enabled = value;
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			if (IsLocalPlayer)
			{
				_lightSource = ViewModel.GetComponentInChildren<Light>(includeInactive: true);
			}
		}

		protected override void OnToggled()
		{
			(ViewModel as FlashlightViewmodel)?.PlayAnimation();
			NextAllowedTime = Time.timeSinceLevelLoad + 0.13f;
		}
	}
}
