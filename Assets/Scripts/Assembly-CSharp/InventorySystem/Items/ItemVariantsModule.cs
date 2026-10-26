using MapGeneration.Holidays;

namespace InventorySystem.Items
{
	public class ItemVariantsModule : VariantsModuleBase<ItemBase>
	{
		private void Reset()
		{
			ItemBase componentInParent = GetComponentInParent<ItemBase>();
			if (!(componentInParent == null))
			{
				componentInParent.VariantsModule = this;
			}
		}
	}
}
