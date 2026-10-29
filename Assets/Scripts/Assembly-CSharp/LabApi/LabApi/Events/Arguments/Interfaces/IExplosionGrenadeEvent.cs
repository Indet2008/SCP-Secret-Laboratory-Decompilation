namespace LabApi.Events.Arguments.Interfaces
{
	public interface IExplosionGrenadeEvent : global::LabApi.Events.Arguments.Interfaces.IProjectileEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		global::LabApi.Features.Wrappers.Projectile? global::LabApi.Events.Arguments.Interfaces.IProjectileEvent.Projectile => ExplosiveGrenade;

		global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile? ExplosiveGrenade { get; }
	}
}
