namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSearchingAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmmoPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.AmmoPickup AmmoPickup { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use AmmoPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => AmmoPickup;

		public PlayerSearchingAmmoEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Ammo.AmmoPickup pickup)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			AmmoPickup = global::LabApi.Features.Wrappers.AmmoPickup.Get(pickup);
		}
	}
}
