namespace LabApi.Events.Arguments.ServerEvents
{
	public class ProjectileExplodedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITimedGrenadeEvent, global::LabApi.Events.Arguments.Interfaces.IProjectileEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.TimedGrenadeProjectile TimedGrenade { get; }

		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public global::UnityEngine.Vector3 Position { get; }

		[global::System.Obsolete("Use TimedGrenade instead")]
		public global::LabApi.Features.Wrappers.TimedGrenadeProjectile Projectile => TimedGrenade;

		public ProjectileExplodedEventArgs(global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade projectile, ReferenceHub hub, global::UnityEngine.Vector3 position)
		{
			TimedGrenade = global::LabApi.Features.Wrappers.TimedGrenadeProjectile.Get(projectile);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
		}
	}
}
