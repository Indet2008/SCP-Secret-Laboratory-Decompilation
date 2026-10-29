namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerThrowingProjectileEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IThrowableItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.ThrowableItem ThrowableItem { get; }

		public global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem.ProjectileSettings ProjectileSettings { get; set; }

		public bool FullForce { get; set; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use ThrowableItem instead")]
		public global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem Item => ThrowableItem.Base;

		public PlayerThrowingProjectileEventArgs(ReferenceHub hub, global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem item, global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem.ProjectileSettings projectileSettings, bool fullForce)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			ThrowableItem = global::LabApi.Features.Wrappers.ThrowableItem.Get(item);
			ProjectileSettings = projectileSettings;
			FullForce = fullForce;
		}
	}
}
