namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerProcessingJailbirdMessageEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.Items.IJailbirdEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.JailbirdItem JailbirdItem { get; }

		public global::InventorySystem.Items.Jailbird.JailbirdMessageType Message { get; set; }

		public bool AllowAttack { get; set; }

		public bool AllowInspect { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerProcessingJailbirdMessageEventArgs(ReferenceHub hub, global::InventorySystem.Items.Jailbird.JailbirdItem jailbird, global::InventorySystem.Items.Jailbird.JailbirdMessageType msg, bool allowAttack, bool allowInspect)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			JailbirdItem = global::LabApi.Features.Wrappers.JailbirdItem.Get(jailbird);
			Message = msg;
			AllowAttack = allowAttack;
			AllowInspect = allowInspect;
			IsAllowed = true;
		}
	}
}
