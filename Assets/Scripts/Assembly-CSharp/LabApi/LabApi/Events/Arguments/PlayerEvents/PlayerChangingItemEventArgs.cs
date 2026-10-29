namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Item? OldItem { get; }

		public global::LabApi.Features.Wrappers.Item? NewItem { get; }

		public bool IsAllowed { get; set; }

		public PlayerChangingItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.ItemBase? oldItem, global::InventorySystem.Items.ItemBase? newItem)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldItem = global::LabApi.Features.Wrappers.Item.Get(oldItem);
			NewItem = global::LabApi.Features.Wrappers.Item.Get(newItem);
		}
	}
}
