namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDroppedItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public bool Throw { get; set; }

		public PlayerDroppedItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Pickups.ItemPickupBase pickup, bool isThrowing)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
			Throw = isThrowing;
		}
	}
}
