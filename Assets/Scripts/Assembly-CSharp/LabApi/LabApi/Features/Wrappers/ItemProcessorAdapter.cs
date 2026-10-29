namespace LabApi.Features.Wrappers
{
	internal class ItemProcessorAdapter : global::Scp914.Processors.Scp914ItemProcessor
	{
		public global::LabApi.Features.Interfaces.IScp914ItemProcessor Processor { get; internal set; }

		public override global::Scp914.Scp914Result UpgradeInventoryItem(global::Scp914.Scp914KnobSetting setting, global::InventorySystem.Items.ItemBase item)
		{
			if (Processor.UsePickupMethodOnly)
			{
				return base.UpgradeInventoryItem(setting, item);
			}
			return Processor.UpgradeItem(setting, global::LabApi.Features.Wrappers.Item.Get(item));
		}

		public override global::Scp914.Scp914Result UpgradePickup(global::Scp914.Scp914KnobSetting setting, global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			return Processor.UpgradePickup(setting, global::LabApi.Features.Wrappers.Pickup.Get(pickup));
		}
	}
}
