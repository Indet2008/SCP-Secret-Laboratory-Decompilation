namespace LabApi.Events.Arguments.Interfaces
{
	public interface ITimedGrenadeEvent : global::LabApi.Events.Arguments.Interfaces.IProjectileEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Projectile? global::LabApi.Events.Arguments.Interfaces.IProjectileEvent.Projectile => TimedGrenade;

		global::LabApi.Features.Wrappers.TimedGrenadeProjectile? TimedGrenade { get; }
	}
}
