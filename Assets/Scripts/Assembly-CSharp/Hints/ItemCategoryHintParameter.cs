using System;
using Mirror;

namespace Hints
{
	public class ItemCategoryHintParameter : IdHintParameter
	{
		public static ItemCategoryHintParameter FromNetwork(NetworkReader reader)
		{
			ItemCategoryHintParameter itemCategoryHintParameter = new ItemCategoryHintParameter();
			itemCategoryHintParameter.Deserialize(reader);
			return itemCategoryHintParameter;
		}

		private ItemCategoryHintParameter()
		{
		}

		public ItemCategoryHintParameter(ItemCategory category)
			: base((byte)(category == ItemCategory.None ? throw new ArgumentException("Item category cannot be none (no proper translation).", "category") : category))
		{
		}

		protected override string FormatId(float progress, out bool stopFormatting)
		{
			stopFormatting = true;
			return TranslationReader.Get("Categories", base.Id, ((ItemCategory)base.Id/*cast due to constrained. prefix*/).ToString());
		}
	}
}
