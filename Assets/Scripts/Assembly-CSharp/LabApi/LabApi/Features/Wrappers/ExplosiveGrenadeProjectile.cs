namespace LabApi.Features.Wrappers
{
	public class ExplosiveGrenadeProjectile : global::LabApi.Features.Wrappers.TimedGrenadeProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade, global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade, global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade Base { get; }

		public global::UnityEngine.LayerMask DetectionMask
		{
			get
			{
				return Base.DetectionMask;
			}
			set
			{
				Base.DetectionMask = value;
			}
		}

		public float MaxRadius
		{
			get
			{
				return Base.MaxRadius;
			}
			set
			{
				Base.MaxRadius = value;
			}
		}

		public float ScpDamageMultiplier
		{
			get
			{
				return Base.ScpDamageMultiplier;
			}
			set
			{
				Base.ScpDamageMultiplier = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile value))
			{
				return (global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal ExplosiveGrenadeProjectile(global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade projectilePickup)
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
