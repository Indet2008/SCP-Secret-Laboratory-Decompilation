namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInspectingItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Item Item { get; }

		public bool IsAllowed { get; set; }

		public PlayerInspectingItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.ItemBase item)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
			IsAllowed = true;
		}
	}
}
