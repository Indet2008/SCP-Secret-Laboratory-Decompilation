namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickingUpItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public bool IsAllowed { get; set; }

		public PlayerPickingUpItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
		}
	}
}
