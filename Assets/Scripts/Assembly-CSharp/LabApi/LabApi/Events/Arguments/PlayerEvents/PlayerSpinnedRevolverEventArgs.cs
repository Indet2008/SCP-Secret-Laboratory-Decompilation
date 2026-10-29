namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpinnedRevolverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRevolverItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RevolverFirearm Revolver { get; }

		public PlayerSpinnedRevolverEventArgs(ReferenceHub hub, global::InventorySystem.Items.Firearms.Firearm weapon)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Revolver = (global::LabApi.Features.Wrappers.RevolverFirearm)global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
		}
	}
}
