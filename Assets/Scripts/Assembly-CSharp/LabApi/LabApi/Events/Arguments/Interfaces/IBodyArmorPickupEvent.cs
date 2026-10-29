namespace LabApi.Events.Arguments.Interfaces
{
	public interface IBodyArmorPickupEvent : global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Pickup? global::LabApi.Events.Arguments.Interfaces.IPickupEvent.Pickup => BodyArmorPickup;

		global::LabApi.Features.Wrappers.BodyArmorPickup? BodyArmorPickup { get; }
	}
}
