namespace LabApi.Events.Arguments.Interfaces
{
	public interface IAmmoPickupEvent : global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Pickup? global::LabApi.Events.Arguments.Interfaces.IPickupEvent.Pickup => AmmoPickup;

		global::LabApi.Features.Wrappers.AmmoPickup? AmmoPickup { get; }
	}
}
