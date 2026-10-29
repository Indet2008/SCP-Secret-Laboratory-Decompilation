namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickingUpAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmmoPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType AmmoType { get; }

		public ushort AmmoAmount { get; set; }

		public global::LabApi.Features.Wrappers.AmmoPickup AmmoPickup { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use AmmoPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => AmmoPickup;

		public PlayerPickingUpAmmoEventArgs(ReferenceHub hub, ItemType ammoType, ushort ammoAmount, global::InventorySystem.Items.Firearms.Ammo.AmmoPickup pickup)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			AmmoType = ammoType;
			AmmoAmount = ammoAmount;
			AmmoPickup = global::LabApi.Features.Wrappers.AmmoPickup.Get(pickup);
		}
	}
}
