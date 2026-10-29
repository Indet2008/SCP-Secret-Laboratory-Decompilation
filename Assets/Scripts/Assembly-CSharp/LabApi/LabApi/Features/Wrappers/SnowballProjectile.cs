namespace LabApi.Features.Wrappers
{
	public class SnowballProjectile : global::LabApi.Features.Wrappers.FlybyDetectorProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile, global::LabApi.Features.Wrappers.SnowballProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile, global::LabApi.Features.Wrappers.SnowballProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SnowballProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.SnowballProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.SnowballProjectile value))
			{
				return (global::LabApi.Features.Wrappers.SnowballProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal SnowballProjectile(global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile projectilePickup)
			: base(projectilePickup)
		{
			Base = projectilePickup;
			if (base.CanCache)
			{
				Dictionary.Add(projectilePickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
