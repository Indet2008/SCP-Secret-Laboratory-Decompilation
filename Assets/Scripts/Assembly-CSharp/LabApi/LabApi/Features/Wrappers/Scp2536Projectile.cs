namespace LabApi.Features.Wrappers
{
	public class Scp2536Projectile : global::LabApi.Features.Wrappers.FlybyDetectorProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile, global::LabApi.Features.Wrappers.Scp2536Projectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile, global::LabApi.Features.Wrappers.Scp2536Projectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp2536Projectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.Scp2536Projectile? Get(global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.Scp2536Projectile value))
			{
				return (global::LabApi.Features.Wrappers.Scp2536Projectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal Scp2536Projectile(global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile projectilePickup)
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
