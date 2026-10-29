namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInspectedKeycardEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IKeycardItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.KeycardItem KeycardItem { get; }

		public PlayerInspectedKeycardEventArgs(ReferenceHub hub, global::InventorySystem.Items.Keycards.KeycardItem keycardItem)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			KeycardItem = global::LabApi.Features.Wrappers.KeycardItem.Get(keycardItem);
		}
	}
}
