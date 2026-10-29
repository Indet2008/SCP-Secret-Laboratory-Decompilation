namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInspectedItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Item Item { get; }

		public PlayerInspectedItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.ItemBase item)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
		}
	}
}
