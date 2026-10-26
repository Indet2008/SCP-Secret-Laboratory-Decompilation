using InventorySystem.Items;
using InventorySystem.Items.Pickups;

namespace Scp914
{
	public readonly struct Scp914Result
	{
		public readonly ItemBase SourceItem;

		public readonly ItemPickupBase SourcePickup;

		public readonly ItemBase[] ResultingItems;

		public readonly ItemPickupBase[] ResultingPickups;

		public Scp914Result(ItemBase source)
		{
			SourceItem = source;
			SourcePickup = null;
			ResultingItems = null;
			ResultingPickups = null;
		}

		public Scp914Result(ItemBase sourceItem, ItemBase[] resultingItems, ItemPickupBase[] resultingPickups)
		{
			SourceItem = sourceItem;
			SourcePickup = null;
			ResultingItems = resultingItems;
			ResultingPickups = resultingPickups;
		}

		public Scp914Result(ItemBase source, ItemBase resultingItem, ItemPickupBase resultingPickup)
		{
			SourceItem = source;
			SourcePickup = null;
			ResultingItems = new ItemBase[1] { resultingItem };
			ResultingPickups = new ItemPickupBase[1] { resultingPickup };
		}

		public Scp914Result(ItemPickupBase source)
		{
			SourceItem = null;
			SourcePickup = source;
			ResultingItems = null;
			ResultingPickups = null;
		}

		public Scp914Result(ItemPickupBase sourcePickup, ItemBase[] resultingItems, ItemPickupBase[] resultingPickups)
		{
			SourceItem = null;
			SourcePickup = sourcePickup;
			ResultingItems = resultingItems;
			ResultingPickups = resultingPickups;
		}

		public Scp914Result(ItemPickupBase source, ItemBase resultingItem, ItemPickupBase resultingPickup)
		{
			SourceItem = null;
			SourcePickup = source;
			ResultingItems = new ItemBase[1] { resultingItem };
			ResultingPickups = new ItemPickupBase[1] { resultingPickup };
		}
	}
}
