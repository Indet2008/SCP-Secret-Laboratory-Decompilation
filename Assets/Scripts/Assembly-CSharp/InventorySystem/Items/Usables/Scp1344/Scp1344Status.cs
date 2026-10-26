namespace InventorySystem.Items.Usables.Scp1344
{
	public enum Scp1344Status : byte
	{
		Idle = 0,
		Equipping = 1,
		Activating = 2,
		Stabbing = 3,
		Active = 4,
		Dropping = 5,
		Deactivating = 6,
		CancelingDeactivation = 7,
		Inspecting = 8
	}
}
