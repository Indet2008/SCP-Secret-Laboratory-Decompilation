namespace InventorySystem.Items
{
	public static class ExternalMobilityControllerItemExtensions
	{
		public static object GetMobilityController(this ItemBase item)
		{
			if (item == null)
			{
				return null;
			}
			if (item is IExternalMobilityControllerItem externalMobilityControllerItem)
			{
				return externalMobilityControllerItem.DesignatedMobilityControllerClass;
			}
			return item;
		}
	}
}
