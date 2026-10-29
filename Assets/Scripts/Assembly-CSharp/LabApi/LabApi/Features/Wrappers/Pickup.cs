namespace LabApi.Features.Wrappers
{
	public class Pickup
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.Pickup>> TypeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.Pickup>>();

		public static global::System.Collections.Generic.Dictionary<ushort, global::LabApi.Features.Wrappers.Pickup> SerialCache { get; } = new global::System.Collections.Generic.Dictionary<ushort, global::LabApi.Features.Wrappers.Pickup>();

		public static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.Pickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.Pickup>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Pickup> List => Dictionary.Values;

		public global::InventorySystem.Items.Pickups.ItemPickupBase Base { get; }

		public global::Mirror.NetworkIdentity NetworkIdentity => Base.netIdentity;

		public global::InventorySystem.Items.Pickups.PickupStandardPhysics? PickupStandardPhysics => Base.PhysicsModule as global::InventorySystem.Items.Pickups.PickupStandardPhysics;

		public global::InventorySystem.Items.Pickups.PickupPhysicsModule PhysicsModule => Base.PhysicsModule;

		public global::UnityEngine.Rigidbody? Rigidbody => PickupStandardPhysics?.Rb;

		public global::UnityEngine.Transform Transform { get; }

		public global::UnityEngine.GameObject GameObject { get; }

		public bool IsDestroyed
		{
			get
			{
				if (!(Base == null))
				{
					return GameObject == null;
				}
				return true;
			}
		}

		public bool IsPrefab { get; }

		public bool IsSpawned => NetworkIdentity.netId != 0;

		public ItemType Type => Base.Info.ItemId;

		public global::LabApi.Features.Wrappers.Player? LastOwner
		{
			get
			{
				if (!(Base.PreviousOwner.Hub != null))
				{
					return null;
				}
				return global::LabApi.Features.Wrappers.Player.Get(Base.PreviousOwner.Hub);
			}
		}

		public ushort Serial => Base.Info.Serial;

		public float Weight
		{
			get
			{
				return Base.Info.WeightKg;
			}
			set
			{
				global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase = Base;
				global::InventorySystem.Items.Pickups.PickupSyncInfo info = Base.Info;
				info.WeightKg = value;
				itemPickupBase.NetworkInfo = info;
			}
		}

		public bool IsLocked
		{
			get
			{
				return Base.Info.Locked;
			}
			set
			{
				global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase = Base;
				global::InventorySystem.Items.Pickups.PickupSyncInfo info = Base.Info;
				info.Locked = value;
				itemPickupBase.NetworkInfo = info;
			}
		}

		public bool IsInUse
		{
			get
			{
				return Base.Info.InUse;
			}
			set
			{
				global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase = Base;
				global::InventorySystem.Items.Pickups.PickupSyncInfo info = Base.Info;
				info.InUse = value;
				itemPickupBase.NetworkInfo = info;
			}
		}

		public global::UnityEngine.Vector3 Position
		{
			get
			{
				return Base.Position;
			}
			set
			{
				Base.Position = value;
			}
		}

		public global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return Base.Rotation;
			}
			set
			{
				Base.Rotation = value;
			}
		}

		public ItemCategory Category
		{
			get
			{
				if (!global::InventorySystem.InventoryItemLoader.AvailableItems.TryGetValue(Type, out var value))
				{
					return ItemCategory.None;
				}
				return value.Category;
			}
		}

		public ItemTierFlags Tier
		{
			get
			{
				if (!global::InventorySystem.InventoryItemLoader.AvailableItems.TryGetValue(Type, out var value))
				{
					return ItemTierFlags.Common;
				}
				return value.TierFlags;
			}
		}

		public global::LabApi.Features.Wrappers.Room? Room => global::LabApi.Features.Wrappers.Room.GetRoomAtPosition(Position);

		protected bool CanCache
		{
			get
			{
				if (!IsDestroyed && !IsPrefab)
				{
					return Base.isActiveAndEnabled;
				}
				return false;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("itemPickupBase")]
		public static global::LabApi.Features.Wrappers.Pickup? Get(global::InventorySystem.Items.Pickups.ItemPickupBase? itemPickupBase)
		{
			if (itemPickupBase == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(itemPickupBase, out global::LabApi.Features.Wrappers.Pickup value))
			{
				return value;
			}
			return CreateItemWrapper(itemPickupBase);
		}

		public static global::LabApi.Features.Wrappers.Pickup? Get(ushort itemSerial)
		{
			return global::System.Collections.Generic.CollectionExtensions.GetValueOrDefault(SerialCache, itemSerial);
		}

		public static bool TryGet(ushort itemSerial, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Pickup? pickup)
		{
			return SerialCache.TryGetValue(itemSerial, out pickup);
		}

		public static global::LabApi.Features.Wrappers.Pickup? Create(ItemType type, global::UnityEngine.Vector3 position)
		{
			return Create(type, position, global::UnityEngine.Quaternion.identity, global::UnityEngine.Vector3.one);
		}

		public static global::LabApi.Features.Wrappers.Pickup? Create(ItemType type, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation)
		{
			return Create(type, position, rotation, global::UnityEngine.Vector3.one);
		}

		public static global::LabApi.Features.Wrappers.Pickup? Create(ItemType type, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			return Create(type, position, rotation, scale, true);
		}

		public static global::LabApi.Features.Wrappers.Pickup? Create(ItemType type, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, bool networkSpawn = true)
		{
			if (type == ItemType.None || !global::InventorySystem.InventoryItemLoader.AvailableItems.TryGetValue(type, out var value))
			{
				return null;
			}
			global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase = global::InventorySystem.InventoryExtensions.ServerCreatePickup(value, new global::InventorySystem.Items.Pickups.PickupSyncInfo(type, value.Weight, 0), position, rotation, spawn: false);
			itemPickupBase.transform.localScale = scale;
			if (networkSpawn)
			{
				global::Mirror.NetworkServer.Spawn(itemPickupBase.gameObject);
			}
			return Get(itemPickupBase);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::InventorySystem.Items.Pickups.ItemPickupBase.OnPickupAdded += AddPickup;
			global::InventorySystem.Items.Pickups.ItemPickupBase.OnPickupDestroyed += RemovePickup;
			Register((global::InventorySystem.Items.ThrowableProjectiles.FlashbangGrenade n) => new global::LabApi.Features.Wrappers.FlashbangProjectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade n) => new global::LabApi.Features.Wrappers.ExplosiveGrenadeProjectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.Scp018Projectile n) => new global::LabApi.Features.Wrappers.Scp018Projectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile n) => new global::LabApi.Features.Wrappers.Scp2176Projectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.SingleTrajectoryProjectile n) => new global::LabApi.Features.Wrappers.SingleTrajectoryProjectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile n) => new global::LabApi.Features.Wrappers.FlybyDetectorProjectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.Scp2536Projectile n) => new global::LabApi.Features.Wrappers.Scp2536Projectile(n));
			Register((global::InventorySystem.Items.ThrowableProjectiles.SnowballProjectile n) => new global::LabApi.Features.Wrappers.SnowballProjectile(n));
			Register((global::InventorySystem.Items.Firearms.Ammo.AmmoPickup x) => new global::LabApi.Features.Wrappers.AmmoPickup(x));
			Register((global::InventorySystem.Items.Armor.BodyArmorPickup x) => new global::LabApi.Features.Wrappers.BodyArmorPickup(x));
			Register((global::InventorySystem.Items.Firearms.FirearmPickup x) => new global::LabApi.Features.Wrappers.FirearmPickup(x));
			Register((global::InventorySystem.Items.Jailbird.JailbirdPickup x) => new global::LabApi.Features.Wrappers.JailbirdPickup(x));
			Register((global::InventorySystem.Items.Keycards.KeycardPickup x) => new global::LabApi.Features.Wrappers.KeycardPickup(x));
			Register((global::InventorySystem.Items.MicroHID.MicroHIDPickup x) => new global::LabApi.Features.Wrappers.MicroHIDPickup(x));
			Register((global::InventorySystem.Items.Radio.RadioPickup x) => new global::LabApi.Features.Wrappers.RadioPickup(x));
			Register((global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup x) => new global::LabApi.Features.Wrappers.Scp1576Pickup(x));
			Register((global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup x) => new global::LabApi.Features.Wrappers.Scp244Pickup(x));
			Register((global::InventorySystem.Items.Usables.Scp330.Scp330Pickup x) => new global::LabApi.Features.Wrappers.Scp330Pickup(x));
			Register((global::InventorySystem.Items.Scp1509.Scp1509Pickup x) => new global::LabApi.Features.Wrappers.Scp1509Pickup(x));
			Register((global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup x) => new global::LabApi.Features.Wrappers.TimedGrenadePickup(x));
			Register((global::InventorySystem.Items.Pickups.CollisionDetectionPickup x) => new global::LabApi.Features.Wrappers.Pickup(x));
		}

		protected static global::LabApi.Features.Wrappers.Pickup CreateItemWrapper(global::InventorySystem.Items.Pickups.ItemPickupBase pickupBase)
		{
			if (TypeWrappers.TryGetValue(pickupBase.GetType(), out global::System.Func<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.Pickup> value))
			{
				return value(pickupBase);
			}
			global::LabApi.Features.Console.Logger.Warn($"Failed to find pickup wrapper for type {pickupBase.GetType()}");
			return new global::LabApi.Features.Wrappers.Pickup(pickupBase);
		}

		private static void AddPickup(global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			try
			{
				if (!Dictionary.ContainsKey(pickup))
				{
					global::LabApi.Events.Handlers.ServerEvents.OnPickupCreated(new global::LabApi.Events.Arguments.ServerEvents.PickupCreatedEventArgs(CreateItemWrapper(pickup)));
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.Error($"Failed to handle pickup creation with error: {arg}");
			}
		}

		private static void RemovePickup(global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			try
			{
				if (Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.Pickup value))
				{
					value.OnRemove();
				}
				global::LabApi.Events.Handlers.ServerEvents.OnPickupDestroyed(new global::LabApi.Events.Arguments.ServerEvents.PickupDestroyedEventArgs(value));
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.Error($"Failed to handle pickup destruction with error: {arg}");
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.Pickup> constructor) where T : global::InventorySystem.Items.Pickups.ItemPickupBase
		{
			TypeWrappers.Add(typeof(T), (global::InventorySystem.Items.Pickups.ItemPickupBase x) => constructor((T)x));
		}

		protected Pickup(global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase)
		{
			Base = itemPickupBase;
			GameObject = itemPickupBase.gameObject;
			Transform = itemPickupBase.transform;
			IsPrefab = global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(itemPickupBase.ItemId.TypeId, out var result) && result.PickupDropModel == itemPickupBase;
			if (!CanCache)
			{
				return;
			}
			if (Dictionary.ContainsKey(itemPickupBase))
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to create a pickup for base: {itemPickupBase}");
				return;
			}
			Dictionary.Add(itemPickupBase, this);
			if (itemPickupBase.Info.Serial != 0)
			{
				SerialCache[itemPickupBase.Info.Serial] = this;
			}
		}

		public void Spawn()
		{
			global::Mirror.NetworkServer.Spawn(GameObject);
		}

		public void Destroy()
		{
			Base.DestroySelf();
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: Type={Type}, IsSpawned={IsSpawned}, IsDestroyed={IsDestroyed}, Position={Position}, Rotation={Rotation}, Room={Room}, IsLocked={IsLocked}, IsInUse={IsInUse}, Serial={Serial}]";
		}

		internal virtual void OnRemove()
		{
			Dictionary.Remove(Base);
			SerialCache.Remove(Serial);
		}
	}
}
