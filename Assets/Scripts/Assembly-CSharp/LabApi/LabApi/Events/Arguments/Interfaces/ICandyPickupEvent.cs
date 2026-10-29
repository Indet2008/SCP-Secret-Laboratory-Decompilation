namespace LabApi.Events.Arguments.Interfaces
{
	public interface ICandyPickupEvent : global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Pickup? global::LabApi.Events.Arguments.Interfaces.IPickupEvent.Pickup => CandyPickup;

		global::LabApi.Features.Wrappers.Scp330Pickup? CandyPickup { get; }
	}
}
