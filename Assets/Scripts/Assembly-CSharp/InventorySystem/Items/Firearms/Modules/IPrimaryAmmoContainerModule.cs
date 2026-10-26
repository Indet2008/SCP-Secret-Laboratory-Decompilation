namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IPrimaryAmmoContainerModule : IAmmoContainerModule
	{
		ItemType AmmoType { get; }

		void ServerModifyAmmo(int amount);
	}
}
