namespace LabApi.Events.Arguments.ServerEvents
{
	public class PickupCreatedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public PickupCreatedEventArgs(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			Pickup = pickup;
		}
	}
}
