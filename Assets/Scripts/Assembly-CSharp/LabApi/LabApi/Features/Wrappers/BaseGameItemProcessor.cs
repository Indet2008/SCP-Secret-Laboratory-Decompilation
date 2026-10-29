namespace LabApi.Features.Wrappers
{
	public class BaseGameItemProcessor : global::LabApi.Features.Interfaces.IScp914ItemProcessor
	{
		public global::Scp914.Processors.Scp914ItemProcessor Processor { get; internal set; }

		public bool UsePickupMethodOnly => false;

		internal BaseGameItemProcessor(global::Scp914.Processors.Scp914ItemProcessor processor)
		{
			Processor = processor;
		}

		public global::Scp914.Scp914Result UpgradeItem(global::Scp914.Scp914KnobSetting setting, global::LabApi.Features.Wrappers.Item item)
		{
			return Processor.UpgradeInventoryItem(setting, item.Base);
		}

		public global::Scp914.Scp914Result UpgradePickup(global::Scp914.Scp914KnobSetting setting, global::LabApi.Features.Wrappers.Pickup pickup)
		{
			return Processor.UpgradePickup(setting, pickup.Base);
		}
	}
}
