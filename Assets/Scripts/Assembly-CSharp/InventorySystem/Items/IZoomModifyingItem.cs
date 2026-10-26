namespace InventorySystem.Items
{
	public interface IZoomModifyingItem
	{
		float ZoomAmount { get; }

		float SensitivityScale { get; }
	}
}
