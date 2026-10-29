namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDryFiringWeaponEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IFirearmItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.FirearmItem FirearmItem { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use FirearmItem instead")]
		public global::LabApi.Features.Wrappers.Item Weapon => FirearmItem;

		public PlayerDryFiringWeaponEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm weapon)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			FirearmItem = global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
		}
	}
}
