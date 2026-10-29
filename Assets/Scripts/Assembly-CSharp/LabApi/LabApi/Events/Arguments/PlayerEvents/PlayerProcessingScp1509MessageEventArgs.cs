namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerProcessingScp1509MessageEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Scp1509Item Scp1509Item { get; }

		public global::InventorySystem.Items.Scp1509.Scp1509MessageType Message { get; set; }

		public bool AllowAttack { get; set; }

		public bool AllowInspect { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerProcessingScp1509MessageEventArgs(ReferenceHub hub, global::InventorySystem.Items.Scp1509.Scp1509Item scp1509Item, global::InventorySystem.Items.Scp1509.Scp1509MessageType msg, bool allowAttack, bool allowInspect)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Scp1509Item = global::LabApi.Features.Wrappers.Scp1509Item.Get(scp1509Item);
			Message = msg;
			AllowAttack = allowAttack;
			AllowInspect = allowInspect;
			IsAllowed = true;
		}
	}
}
