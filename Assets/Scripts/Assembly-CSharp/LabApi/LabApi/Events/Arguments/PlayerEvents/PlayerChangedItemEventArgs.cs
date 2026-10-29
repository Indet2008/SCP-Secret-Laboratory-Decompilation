namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangedItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Item? OldItem { get; }

		public global::LabApi.Features.Wrappers.Item? NewItem { get; }

		public PlayerChangedItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.ItemBase? oldItem, global::InventorySystem.Items.ItemBase? newItem)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldItem = global::LabApi.Features.Wrappers.Item.Get(oldItem);
			NewItem = global::LabApi.Features.Wrappers.Item.Get(newItem);
		}
	}
}
