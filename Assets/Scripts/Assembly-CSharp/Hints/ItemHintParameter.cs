using System;
using InventorySystem;
using InventorySystem.Items;
using Mirror;

namespace Hints
{
	public class ItemHintParameter : IdHintParameter
	{
		public static ItemHintParameter FromNetwork(NetworkReader reader)
		{
			ItemHintParameter itemHintParameter = new ItemHintParameter();
			itemHintParameter.Deserialize(reader);
			return itemHintParameter;
		}

		private ItemHintParameter()
		{
		}

		public ItemHintParameter(ItemType item)
			: base((byte)item)
		{
			if (item == ItemType.None)
			{
				throw new ArgumentException("Item cannot be none (no proper translation).", "item");
			}
		}

		protected override string FormatId(float progress, out bool stopFormatting)
		{
			stopFormatting = true;
			ItemType id = (ItemType)base.Id;
			if (!InventoryItemLoader.AvailableItems.TryGetValue(id, out var value) || !(value is IItemNametag itemNametag))
			{
				return id.ToString();
			}
			return itemNametag.Name;
		}
	}
}
