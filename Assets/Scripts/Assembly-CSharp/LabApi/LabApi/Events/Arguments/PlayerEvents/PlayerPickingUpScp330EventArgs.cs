namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickingUpScp330EventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICandyPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Scp330Pickup CandyPickup { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use CandyPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => CandyPickup;

		public PlayerPickingUpScp330EventArgs(ReferenceHub hub, global::InventorySystem.Items.Usables.Scp330.Scp330Pickup pickup)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			CandyPickup = global::LabApi.Features.Wrappers.Scp330Pickup.Get(pickup);
		}
	}
}
