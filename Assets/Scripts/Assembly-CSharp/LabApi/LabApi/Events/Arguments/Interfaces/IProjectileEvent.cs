namespace LabApi.Events.Arguments.Interfaces
{
	public interface IProjectileEvent : global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Pickup? global::LabApi.Events.Arguments.Interfaces.IPickupEvent.Pickup => Projectile;

		global::LabApi.Features.Wrappers.Projectile? Projectile { get; }
	}
}
