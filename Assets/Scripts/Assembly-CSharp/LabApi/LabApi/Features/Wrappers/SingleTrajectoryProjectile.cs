namespace LabApi.Features.Wrappers
{
	public class SingleTrajectoryProjectile : global::LabApi.Features.Wrappers.Projectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile, global::LabApi.Features.Wrappers.SingleTrajectoryProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile, global::LabApi.Features.Wrappers.SingleTrajectoryProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SingleTrajectoryProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.SingleTrajectoryProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.SingleTrajectoryProjectile value))
			{
				return (global::LabApi.Features.Wrappers.SingleTrajectoryProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal SingleTrajectoryProjectile(global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile projectilePickup)
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
