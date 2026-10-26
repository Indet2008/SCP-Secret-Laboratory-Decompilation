using System;

namespace InventorySystem.Items
{
	[Flags]
	public enum BlockedInteraction : byte
	{
		GeneralInteractions = 1,
		OpenInventory = 2,
		BeDisarmed = 4,
		GrabItems = 8,
		ItemPrimaryAction = 0x10,
		ItemUsage = 0x30,
		UndisarmPlayers = 0x40,
		All = byte.MaxValue
	}
}
