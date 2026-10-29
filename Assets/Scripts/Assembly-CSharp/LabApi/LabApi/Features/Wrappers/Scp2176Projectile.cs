namespace LabApi.Features.Wrappers
{
	public class Scp2176Projectile : global::LabApi.Features.Wrappers.TimedGrenadeProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile, global::LabApi.Features.Wrappers.Scp2176Projectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile, global::LabApi.Features.Wrappers.Scp2176Projectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp2176Projectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile Base { get; }

		public float LockdownDuration
		{
			get
			{
				return Base.LockdownDuration;
			}
			set
			{
				Base.LockdownDuration = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.Scp2176Projectile? Get(global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.Scp2176Projectile value))
			{
				return (global::LabApi.Features.Wrappers.Scp2176Projectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal Scp2176Projectile(global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile projectilePickup)
			: base(projectilePickup)
		{
			Base = projectilePickup;
			if (base.CanCache)
			{
				Dictionary.Add(projectilePickup, this);
			}
		}

		public void PlaySound()
		{
			Base.RpcMakeSound();
		}

		public override void FuseEnd()
		{
			Base.ServerImmediatelyShatter();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
