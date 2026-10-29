namespace LabApi.Events.Arguments.ServerEvents
{
	public class ProjectileExplodingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITimedGrenadeEvent, global::LabApi.Events.Arguments.Interfaces.IProjectileEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.TimedGrenadeProjectile TimedGrenade { get; }

		public global::LabApi.Features.Wrappers.Player? Player { get; set; }

		public global::UnityEngine.Vector3 Position { get; set; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use TimedGrenade instead")]
		public global::LabApi.Features.Wrappers.TimedGrenadeProjectile Grenade => TimedGrenade;

		public ProjectileExplodingEventArgs(global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade grenade, ReferenceHub hub, global::UnityEngine.Vector3 position)
		{
			TimedGrenade = global::LabApi.Features.Wrappers.TimedGrenadeProjectile.Get(grenade);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
			IsAllowed = true;
		}
	}
}
