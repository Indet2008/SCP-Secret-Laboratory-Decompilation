using System;

namespace Scp914
{
	[Flags]
	public enum Scp914Mode
	{
		Dropped = 1,
		Inventory = 2,
		Held = 6,
		DroppedAndPlayerTeleport = 5,
		DroppedAndInventory = Dropped | Inventory,
		DroppedAndHeld = Held | Dropped
	}
}
