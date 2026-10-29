namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerThrewProjectileEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IThrowableItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.IProjectileEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.ThrowableItem ThrowableItem { get; }

		public global::LabApi.Features.Wrappers.Projectile Projectile { get; }

		public global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem.ProjectileSettings ProjectileSettings { get; }

		public bool FullForce { get; }

		[global::System.Obsolete("Use ThrowableItem instead")]
		public global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem Item => ThrowableItem.Base;

		public PlayerThrewProjectileEventArgs(ReferenceHub hub, global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem item, global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile projectile, global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem.ProjectileSettings projectileSettings, bool fullForce)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			ThrowableItem = global::LabApi.Features.Wrappers.ThrowableItem.Get(item);
			Projectile = global::LabApi.Features.Wrappers.Projectile.Get(projectile);
			ProjectileSettings = projectileSettings;
			FullForce = fullForce;
		}
	}
}
