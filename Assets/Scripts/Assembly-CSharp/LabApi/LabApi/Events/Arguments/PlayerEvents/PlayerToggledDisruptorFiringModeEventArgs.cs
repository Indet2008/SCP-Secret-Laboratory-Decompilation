namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerToggledDisruptorFiringModeEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IFirearmItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.FirearmItem FirearmItem { get; }

		public bool SingleShotMode { get; }

		public PlayerToggledDisruptorFiringModeEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm weapon, bool singleShot)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			FirearmItem = global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
			SingleShotMode = singleShot;
		}
	}
}
