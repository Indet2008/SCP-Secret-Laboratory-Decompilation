namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpinningRevolverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRevolverItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RevolverFirearm Revolver { get; }

		public bool IsAllowed { get; set; }

		public PlayerSpinningRevolverEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm weapon)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Revolver = (global::LabApi.Features.Wrappers.RevolverFirearm)global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
			IsAllowed = true;
		}
	}
}
