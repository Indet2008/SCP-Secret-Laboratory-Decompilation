namespace LabApi.Features.Wrappers
{
	public class Projectile : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile, global::LabApi.Features.Wrappers.Projectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile, global::LabApi.Features.Wrappers.Projectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Projectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.Projectile? Get(global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.Projectile value))
			{
				return (global::LabApi.Features.Wrappers.Projectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		protected Projectile(global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile projectilePickup)
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
