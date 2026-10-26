using AudioPooling;
using InventorySystem.Items.ToggleableLights.Flashlight;

namespace InventorySystem.Items.ToggleableLights.Lantern
{
	public class LanternViewmodel : StandardAnimatedViemodel
	{
		public LanternLightManager LanternLightManager;

		public void SetLightStatus(bool lightEnabled)
		{
			LanternLightManager.SetLight(lightEnabled);
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			LanternLightManager = GetComponentInChildren<LanternLightManager>(includeInactive: true);
			FlashlightNetworkHandler.OnStatusReceived += OnStatusReceived;
			SetLightStatus(!FlashlightNetworkHandler.ReceivedStatuses.TryGetValue(base.ItemId.SerialNumber, out var value) | value);
			if (wasEquipped)
			{
				AnimatorForceUpdate(base.SkipEquipTime);
			}
		}

		private void OnStatusReceived(FlashlightNetworkHandler.FlashlightMessage msg)
		{
			if (msg.Serial == base.ItemId.SerialNumber && LanternLightManager.IsEnabled != msg.NewState)
			{
				SetLightStatus(msg.NewState);
				AudioSourcePoolManager.Play2DWithParent(msg.NewState ? FlashlightItem.Template.OnClip : FlashlightItem.Template.OffClip, base.transform);
			}
		}

		private void OnDestroy()
		{
			if (base.IsSpectator)
			{
				FlashlightNetworkHandler.OnStatusReceived -= OnStatusReceived;
			}
		}
	}
}
