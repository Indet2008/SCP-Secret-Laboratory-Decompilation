namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerCancellingUsingItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IUsableItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.UsableItem UsableItem { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use UsableItem instead")]
		public global::InventorySystem.Items.Usables.UsableItem Item => UsableItem.Base;

		public PlayerCancellingUsingItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Usables.UsableItem item)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			UsableItem = global::LabApi.Features.Wrappers.UsableItem.Get(item);
		}
	}
}
