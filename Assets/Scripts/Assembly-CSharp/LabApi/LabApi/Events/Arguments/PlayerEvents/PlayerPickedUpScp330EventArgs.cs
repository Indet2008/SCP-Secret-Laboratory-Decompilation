namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickedUpScp330EventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICandyItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICandyPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Scp330Pickup CandyPickup { get; }

		public global::LabApi.Features.Wrappers.Scp330Item CandyItem { get; }

		[global::System.Obsolete("Use CandyPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => CandyPickup;

		[global::System.Obsolete("Use CandyItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => CandyItem;

		public PlayerPickedUpScp330EventArgs(ReferenceHub hub, global::InventorySystem.Items.Usables.Scp330.Scp330Pickup pickup, global::InventorySystem.Items.Usables.Scp330.Scp330Bag item)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			CandyPickup = global::LabApi.Features.Wrappers.Scp330Pickup.Get(pickup);
			CandyItem = global::LabApi.Features.Wrappers.Scp330Item.Get(item);
		}
	}
}
