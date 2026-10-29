namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessingInventoryItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::Scp914.Scp914KnobSetting KnobSetting { get; set; }

		public global::LabApi.Features.Wrappers.Item Item { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp914ProcessingInventoryItemEventArgs(global::InventorySystem.Items.ItemBase item, global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			IsAllowed = true;
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
