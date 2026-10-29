namespace LabApi.Features.Wrappers
{
	public class TimedGrenadeProjectile : global::LabApi.Features.Wrappers.Projectile
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade, global::LabApi.Features.Wrappers.TimedGrenadeProjectile> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade, global::LabApi.Features.Wrappers.TimedGrenadeProjectile>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.TimedGrenadeProjectile> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade Base { get; }

		public double RemainingTime
		{
			get
			{
				return Base.TargetTime;
			}
			set
			{
				Base.TargetTime = global::Mirror.NetworkTime.time + value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("projectile")]
		public static global::LabApi.Features.Wrappers.TimedGrenadeProjectile? Get(global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade? projectile)
		{
			if (projectile == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(projectile, out global::LabApi.Features.Wrappers.TimedGrenadeProjectile value))
			{
				return (global::LabApi.Features.Wrappers.TimedGrenadeProjectile)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(projectile);
			}
			return value;
		}

		public static void PlayEffect(global::UnityEngine.Vector3 position, ItemType type)
		{
			global::Utils.ExplosionUtils.ServerSpawnEffect(position, type);
		}

		public static global::LabApi.Features.Wrappers.TimedGrenadeProjectile? SpawnActive(global::UnityEngine.Vector3 pos, ItemType type, global::LabApi.Features.Wrappers.Player? owner = null, double timeOverride = -1.0)
		{
			if (!global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem>(type, out var result))
			{
				return null;
			}
			if (!(result.Projectile is global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade original))
			{
				return null;
			}
			global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade timeGrenade = global::UnityEngine.Object.Instantiate(original, pos, global::UnityEngine.Quaternion.identity);
			global::InventorySystem.Items.Pickups.PickupSyncInfo info = new global::InventorySystem.Items.Pickups.PickupSyncInfo(result.ItemTypeId, result.Weight, 0, locked: true);
			timeGrenade.Info = info;
			timeGrenade.PreviousOwner = new global::Footprinting.Footprint(owner?.ReferenceHub);
			global::Mirror.NetworkServer.Spawn(timeGrenade.gameObject);
			timeGrenade.ServerActivate();
			global::LabApi.Features.Wrappers.TimedGrenadeProjectile timedGrenadeProjectile = (global::LabApi.Features.Wrappers.TimedGrenadeProjectile)global::LabApi.Features.Wrappers.Pickup.Get(timeGrenade);
			if (timeOverride >= 0.0)
			{
				timedGrenadeProjectile.RemainingTime = timeOverride;
			}
			return timedGrenadeProjectile;
		}

		internal TimedGrenadeProjectile(global::InventorySystem.Items.ThrowableProjectiles.TimeGrenade projectilePickup)
			: base(projectilePickup)
		{
			Base = projectilePickup;
			if (base.CanCache)
			{
				Dictionary.Add(projectilePickup, this);
			}
		}

		public virtual void FuseEnd()
		{
			Base.ServerFuseEnd();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
