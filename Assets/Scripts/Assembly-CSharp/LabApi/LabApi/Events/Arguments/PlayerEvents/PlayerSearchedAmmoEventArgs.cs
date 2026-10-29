namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSearchedAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmmoPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.AmmoPickup AmmoPickup { get; }

		[global::System.Obsolete("Use AmmoPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => AmmoPickup;

		public PlayerSearchedAmmoEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Ammo.AmmoPickup pickup)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			AmmoPickup = global::LabApi.Features.Wrappers.AmmoPickup.Get(pickup);
		}
	}
}
