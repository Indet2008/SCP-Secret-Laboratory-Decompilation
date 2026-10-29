namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerProcessedJailbirdMessageEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.Items.IJailbirdEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.JailbirdItem JailbirdItem { get; }

		public global::InventorySystem.Items.Jailbird.JailbirdMessageType Message { get; }

		public PlayerProcessedJailbirdMessageEventArgs(ReferenceHub hub, global::InventorySystem.Items.Jailbird.JailbirdItem jailbird, global::InventorySystem.Items.Jailbird.JailbirdMessageType msg)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			JailbirdItem = global::LabApi.Features.Wrappers.JailbirdItem.Get(jailbird);
			Message = msg;
		}
	}
}
