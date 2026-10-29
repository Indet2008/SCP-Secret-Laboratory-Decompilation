namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInspectingKeycardEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IKeycardItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.KeycardItem KeycardItem { get; }

		public bool IsAllowed { get; set; }

		public PlayerInspectingKeycardEventArgs(ReferenceHub hub, global::InventorySystem.Items.Keycards.KeycardItem keycardItem)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			KeycardItem = global::LabApi.Features.Wrappers.KeycardItem.Get(keycardItem);
			IsAllowed = true;
		}
	}
}
