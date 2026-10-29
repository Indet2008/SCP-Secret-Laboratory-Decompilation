namespace LabApi.Features.Wrappers
{
	public class FlashbangProjectile : global::LabApi.Features.Wrappers.TimedGrenadeProjectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade, global::LabApi.Features.Wrappers.FlashbangProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade, global::LabApi.Features.Wrappers.FlashbangProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.FlashbangProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade Base { get; }

		public global::UnityEngine.LayerMask BlockingMask
		{
			get
			{
				return Base.BlindingMask;
			}
			set
			{
				Base.BlindingMask = value;
			}
		}

		public float BaseBlindTime
		{
			get
			{
				return Base.BlindTime;
			}
			set
			{
				Base.BlindTime = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.FlashbangProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.FlashbangProjectile value))
			{
				return (global::LabApi.Features.Wrappers.FlashbangProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		internal FlashbangProjectile(global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade projectilePickup)
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
