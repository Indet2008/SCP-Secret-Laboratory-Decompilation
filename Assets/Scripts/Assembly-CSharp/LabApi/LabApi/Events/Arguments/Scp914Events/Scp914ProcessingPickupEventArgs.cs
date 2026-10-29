namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessingPickupEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::UnityEngine.Vector3 NewPosition { get; set; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; set; }

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public bool IsAllowed { get; set; }

		public Scp914ProcessingPickupEventArgs(global::UnityEngine.Vector3 newPosition, global::Scp914.Scp914KnobSetting knobSetting, global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			IsAllowed = true;
			NewPosition = newPosition;
			KnobSetting = knobSetting;
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
		}
	}
}
