namespace LabApi.Features.Wrappers
{
	public class FlybyDetectorProjectile : global::LabApi.Features.Wrappers.SingleTrajectoryProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile, global::LabApi.Features.Wrappers.FlybyDetectorProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile, global::LabApi.Features.Wrappers.FlybyDetectorProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.FlybyDetectorProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.FlybyDetectorProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.FlybyDetectorProjectile value))
			{
				return (global::LabApi.Features.Wrappers.FlybyDetectorProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal FlybyDetectorProjectile(global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile projectilePickup)
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
