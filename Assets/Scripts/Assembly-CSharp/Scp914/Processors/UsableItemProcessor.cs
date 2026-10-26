using InventorySystem.Items;
using InventorySystem.Items.Usables;

namespace Scp914.Processors
{
	public class UsableItemProcessor : StandardItemProcessor
	{
		public override Scp914Result UpgradeInventoryItem(Scp914KnobSetting setting, ItemBase sourceItem)
		{
			if (!(sourceItem is UsableItem { IsUsing: not false }))
			{
				return base.UpgradeInventoryItem(setting, sourceItem);
			}
			return new Scp914Result(sourceItem, sourceItem, null);
		}
	}
}
