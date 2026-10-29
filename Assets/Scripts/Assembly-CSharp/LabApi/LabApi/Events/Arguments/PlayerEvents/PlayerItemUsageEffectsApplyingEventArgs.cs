namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerItemUsageEffectsApplyingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IUsableItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.UsableItem UsableItem { get; }

		public bool ContinueProcess { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerItemUsageEffectsApplyingEventArgs(ReferenceHub hub, global::InventorySystem.Items.Usables.UsableItem item)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			UsableItem = global::LabApi.Features.Wrappers.UsableItem.Get(item);
		}
	}
}
