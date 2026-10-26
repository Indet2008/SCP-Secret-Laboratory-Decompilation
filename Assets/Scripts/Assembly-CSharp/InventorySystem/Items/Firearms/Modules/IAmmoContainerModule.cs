namespace InventorySystem.Items.Firearms.Modules
{
	public interface IAmmoContainerModule
	{
		int AmmoStored { get; }

		int AmmoMax { get; }

		int GetAmmoStoredForSerial(ushort serial);
	}
}
