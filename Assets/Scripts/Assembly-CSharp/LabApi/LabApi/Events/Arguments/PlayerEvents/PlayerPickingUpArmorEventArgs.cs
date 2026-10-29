namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickingUpArmorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IBodyArmorPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.BodyArmorPickup BodyArmorPickup { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use BodyArmorPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => BodyArmorPickup;

		public PlayerPickingUpArmorEventArgs(ReferenceHub hub, global::InventorySystem.Items.Armor.BodyArmorPickup pickup)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			BodyArmorPickup = global::LabApi.Features.Wrappers.BodyArmorPickup.Get(pickup);
		}
	}
}
