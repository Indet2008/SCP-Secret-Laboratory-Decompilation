namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickedUpAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmmoPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType AmmoType { get; }

		public ushort AmmoAmount { get; }

		public global::LabApi.Features.Wrappers.AmmoPickup? AmmoPickup { get; }

		[global::System.Obsolete("Use AmmoPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup? Pickup => AmmoPickup;

		public PlayerPickedUpAmmoEventArgs(ReferenceHub hub, ItemType ammoType, ushort ammoAmount, global::InventorySystem.Items.Firearms.Ammo.AmmoPickup pickup)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			AmmoType = ammoType;
			AmmoAmount = ammoAmount;
			AmmoPickup = global::LabApi.Features.Wrappers.AmmoPickup.Get(pickup);
		}
	}
}
