namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessedInventoryItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public ItemType OldItemType { get; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; }

		public global::LabApi.Features.Wrappers.Item Item { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp914ProcessedInventoryItemEventArgs(ItemType oldItemType, global::InventorySystem.Items.ItemBase item, global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			OldItemType = oldItemType;
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
