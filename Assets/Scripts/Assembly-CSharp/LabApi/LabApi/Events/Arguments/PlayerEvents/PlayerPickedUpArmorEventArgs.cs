namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPickedUpArmorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IBodyArmorItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.BodyArmorItem? BodyArmorItem { get; }

		[global::System.Obsolete("Use BodyArmorItem instead")]
		public global::LabApi.Features.Wrappers.Item? Item => BodyArmorItem;

		public PlayerPickedUpArmorEventArgs(ReferenceHub hub, global::InventorySystem.Items.Armor.BodyArmor? armor)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			BodyArmorItem = global::LabApi.Features.Wrappers.BodyArmorItem.Get(armor);
		}
	}
}
