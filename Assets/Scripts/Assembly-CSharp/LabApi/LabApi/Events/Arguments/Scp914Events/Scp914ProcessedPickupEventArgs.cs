namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessedPickupEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public ItemType OldItemType { get; }

		public global::UnityEngine.Vector3 NewPosition { get; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; }

		public global::LabApi.Features.Wrappers.Pickup? Pickup { get; }

		public Scp914ProcessedPickupEventArgs(ItemType oldItemType, global::UnityEngine.Vector3 newPosition, global::Scp914.Scp914KnobSetting knobSetting, global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			OldItemType = oldItemType;
			NewPosition = newPosition;
			KnobSetting = knobSetting;
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
		}
	}
}
