namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerProcessedScp1509MessageEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Scp1509Item Scp1509Item { get; }

		public global::InventorySystem.Items.Scp1509.Scp1509MessageType Message { get; }

		public PlayerProcessedScp1509MessageEventArgs(ReferenceHub hub, global::InventorySystem.Items.Scp1509.Scp1509Item scp1509Item, global::InventorySystem.Items.Scp1509.Scp1509MessageType msg)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Scp1509Item = global::LabApi.Features.Wrappers.Scp1509Item.Get(scp1509Item);
			Message = msg;
		}
	}
}
