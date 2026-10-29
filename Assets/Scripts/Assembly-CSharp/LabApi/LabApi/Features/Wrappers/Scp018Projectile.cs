namespace LabApi.Features.Wrappers
{
	public class Scp018Projectile : global::LabApi.Features.Wrappers.TimedGrenadeProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile, global::LabApi.Features.Wrappers.Scp018Projectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile, global::LabApi.Features.Wrappers.Scp018Projectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp018Projectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile Base { get; }

		public float CurrentDamage => Base.CurrentDamage;

		public global::UnityEngine.Vector3 Velocity
		{
			get
			{
				if (base.PickupStandardPhysics == null)
				{
					return global::UnityEngine.Vector3.zero;
				}
				return base.PickupStandardPhysics.Rb.linearVelocity;
			}
			set
			{
				if (base.PickupStandardPhysics != null)
				{
					base.PickupStandardPhysics.Rb.linearVelocity = value;
				}
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.Scp018Projectile? Get(global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.Scp018Projectile value))
			{
				return (global::LabApi.Features.Wrappers.Scp018Projectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal Scp018Projectile(global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile projectilePickup)
			: base(projectilePickup)
		{
			Base = projectilePickup;
			if (base.CanCache)
			{
				Dictionary.Add(projectilePickup, this);
			}
		}

		public void PlayBounceSound(float velSqrt = -1f)
		{
			Base.RpcPlayBounce((velSqrt < 0f) ? Velocity.sqrMagnitude : velSqrt);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
