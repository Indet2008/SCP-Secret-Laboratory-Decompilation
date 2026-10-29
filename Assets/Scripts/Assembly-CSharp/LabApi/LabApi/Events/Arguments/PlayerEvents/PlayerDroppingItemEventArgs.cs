namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDroppingItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Item Item { get; }

		public bool Throw { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerDroppingItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.ItemBase item, bool isThrowing)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
			Throw = isThrowing;
		}
	}
}
