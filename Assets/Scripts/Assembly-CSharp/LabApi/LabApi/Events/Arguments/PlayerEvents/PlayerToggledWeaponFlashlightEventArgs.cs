namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerToggledWeaponFlashlightEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IFirearmItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.FirearmItem FirearmItem { get; }

		public bool NewState { get; }

		[global::System.Obsolete("Use FirearmItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => FirearmItem;

		public PlayerToggledWeaponFlashlightEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm item, bool newState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			FirearmItem = global::LabApi.Features.Wrappers.FirearmItem.Get(item);
			NewState = newState;
		}
	}
}
