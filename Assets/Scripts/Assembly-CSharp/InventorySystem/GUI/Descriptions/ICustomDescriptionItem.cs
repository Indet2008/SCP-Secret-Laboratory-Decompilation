namespace InventorySystem.GUI.Descriptions
{
	public interface ICustomDescriptionItem
	{
		CustomDescriptionGui CustomGuiPrefab { get; }

		string[] CustomDescriptionContent { get; }
	}
}
