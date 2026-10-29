namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUsedItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IUsableItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.UsableItem UsableItem { get; }

		[global::System.Obsolete("Use UsableItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => UsableItem;

		public PlayerUsedItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Usables.UsableItem item)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			UsableItem = global::LabApi.Features.Wrappers.UsableItem.Get(item);
		}
	}
}
