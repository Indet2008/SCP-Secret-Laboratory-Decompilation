namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface ISpectatorSyncModule
	{
		void SetupViewmodel(AnimatedFirearmViewmodel viewmodel, float defaultSkipTime);
	}
}
