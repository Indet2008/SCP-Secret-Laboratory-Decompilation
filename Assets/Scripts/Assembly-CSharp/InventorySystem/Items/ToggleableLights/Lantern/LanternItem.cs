using InventorySystem.Items.Pickups;
using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Lantern
{
	public class LanternItem : ToggleableLightItemBase
	{
		private const float LanternCooldownTime = 0.25f;

		private LanternViewmodel _lanternViewmodel;

		public override float Weight => 0.7f;

		protected override void OnToggled()
		{
			SetLightSourceStatus(!IsEmittingLight);
			NextAllowedTime = Time.timeSinceLevelLoad + 0.13f + 0.25f;
			ClientSendRequest(!IsEmittingLight);
		}

		protected override void SetLightSourceStatus(bool value)
		{
			_lanternViewmodel.SetLightStatus(value);
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			if (IsLocalPlayer)
			{
				_lanternViewmodel = ViewModel as LanternViewmodel;
			}
		}
	}
}
