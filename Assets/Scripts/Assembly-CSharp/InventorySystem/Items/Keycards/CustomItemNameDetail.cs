using System;
using Mirror;

namespace InventorySystem.Items.Keycards
{
	public class CustomItemNameDetail : SyncedDetail, ICustomizableDetail, IItemNametag
	{
		private static string _customText;

		public string[] CommandArguments => new string[1] { "Inventory item name (use '_' instead of spaces)" };

		public string Name { get; private set; }

		public int CustomizablePropertiesAmount => 1;

		public void ParseArguments(ArraySegment<string> args)
		{
			_customText = args.At(0).Replace('_', ' ');
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customText = (string)args.At(0);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteString(null);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			writer.WriteString(_customText);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			writer.WriteString(_customText);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			string text = reader.ReadString() ?? string.Empty;
			if (!target.transform.TryGetComponentInParent<KeycardItem>(out var comp))
			{
				return;
			}
			DetailBase[] details = comp.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is CustomItemNameDetail customItemNameDetail)
				{
					customItemNameDetail.Name = text;
					break;
				}
			}
		}
	}
}
