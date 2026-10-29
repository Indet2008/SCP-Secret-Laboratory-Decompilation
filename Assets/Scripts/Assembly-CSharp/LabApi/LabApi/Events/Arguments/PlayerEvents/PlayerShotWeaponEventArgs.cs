namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerShotWeaponEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IFirearmItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.FirearmItem FirearmItem { get; }

		[global::System.Obsolete("Use FirearmItem instead")]
		public global::LabApi.Features.Wrappers.Item Weapon => FirearmItem;

		public PlayerShotWeaponEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm weapon)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			FirearmItem = global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
		}
	}
}
