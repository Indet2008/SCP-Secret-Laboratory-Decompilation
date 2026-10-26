using InventorySystem;
using InventorySystem.Items;
using Mirror;

namespace Hints
{
	public class AmmoHintParameter : IdHintParameter
	{
		public static AmmoHintParameter FromNetwork(NetworkReader reader)
		{
			AmmoHintParameter ammoHintParameter = new AmmoHintParameter();
			ammoHintParameter.Deserialize(reader);
			return ammoHintParameter;
		}

		private AmmoHintParameter()
		{
		}

		public AmmoHintParameter(byte id)
			: base(id)
		{
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
