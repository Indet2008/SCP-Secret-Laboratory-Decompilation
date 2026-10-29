namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSearchedArmorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IBodyArmorPickupEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.BodyArmorPickup BodyArmorPickup { get; }

		[global::System.Obsolete("Use BodyArmorPickup instead")]
		public global::LabApi.Features.Wrappers.Pickup Pickup => BodyArmorPickup;

		public PlayerSearchedArmorEventArgs(ReferenceHub hub, global::InventorySystem.Items.Armor.BodyArmorPickup pickup)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			BodyArmorPickup = global::LabApi.Features.Wrappers.BodyArmorPickup.Get(pickup);
		}
	}
}
