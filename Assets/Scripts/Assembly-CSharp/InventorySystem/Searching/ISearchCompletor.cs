namespace InventorySystem.Searching
{
	public interface ISearchCompletor
	{
		ReferenceHub Hub { get; }

		bool ValidateStart();

		bool ValidateUpdate();

		void Complete();
	}
}
