namespace LabApi.Events.Arguments.ServerEvents
{
	public class PickupDestroyedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public PickupDestroyedEventArgs(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			Pickup = pickup;
		}
	}
}
