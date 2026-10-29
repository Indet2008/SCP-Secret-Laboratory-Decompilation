namespace LabApi.Events.Arguments.ServerEvents
{
	public class ItemSpawnedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public ItemSpawnedEventArgs(global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
		}
	}
}
