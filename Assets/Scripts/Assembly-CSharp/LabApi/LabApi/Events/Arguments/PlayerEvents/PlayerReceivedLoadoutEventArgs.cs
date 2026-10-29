namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerReceivedLoadoutEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Collections.Generic.List<ItemType> Items { get; }

		public global::System.Collections.Generic.Dictionary<ItemType, ushort> Ammo { get; }

		public bool InventoryReset { get; }

		public PlayerReceivedLoadoutEventArgs(ReferenceHub hub, global::System.Collections.Generic.List<ItemType> items, global::System.Collections.Generic.Dictionary<ItemType, ushort> ammo, bool inventoryReset)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Items = items;
			Ammo = ammo;
			InventoryReset = inventoryReset;
		}
	}
}
