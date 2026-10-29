namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDroppedAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmmoPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType Type { get; }

		public int Amount { get; }

		public global::LabApi.Features.Wrappers.AmmoPickup AmmoPickup { get; }

		[global::System.Obsolete("Use AmmoPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => AmmoPickup;

		public PlayerDroppedAmmoEventArgs(ReferenceHub hub, ItemType type, int amount, global::InventorySystem.Items.Firearms.Ammo.AmmoPickup pickup)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Type = type;
			Amount = amount;
			AmmoPickup = global::LabApi.Features.Wrappers.AmmoPickup.Get(pickup);
		}
	}
}
