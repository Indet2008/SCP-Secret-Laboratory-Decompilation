namespace InventorySystem.Items.Firearms.Modules
{
	public interface IRecommendableModule
	{
		bool TryGetProgrammersRecommendation(Firearm targetFirearm, out string message);
	}
}
