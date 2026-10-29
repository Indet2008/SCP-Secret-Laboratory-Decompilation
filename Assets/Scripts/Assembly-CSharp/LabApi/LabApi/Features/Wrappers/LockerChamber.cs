namespace LabApi.Features.Wrappers
{
	public class LockerChamber
	{
		public static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.LockerChamber, global::LabApi.Features.Wrappers.LockerChamber> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.LockerChamber, global::LabApi.Features.Wrappers.LockerChamber>();

		public global::MapGeneration.Distributors.LockerChamber Base { get; }

		public global::LabApi.Features.Wrappers.Locker Locker { get; }

		public byte Id { get; }

		public bool IsOpen
		{
			get
			{
				return Base.IsOpen;
			}
			set
			{
				Base.SetDoor(value, null);
				Locker.Base.RefreshOpenedSyncvar();
			}
		}

		public bool CanInteract => Base.CanInteract;

		public bool IsEmpty => global::System.Linq.Enumerable.All(Base.Content, (global::InventorySystem.Items.Pickups.ItemPickupBase x) => x == null);

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags RequiredPermissions
		{
			get
			{
				return Base.RequiredPermissions;
			}
			set
			{
				Base.RequiredPermissions = value;
			}
		}

		public float TargetCooldown
		{
			get
			{
				return Base.TargetCooldown;
			}
			set
			{
				Base.TargetCooldown = value;
			}
		}

		public bool SpawnOnFirstOpening => Base.SpawnOnFirstChamberOpening;

		public ItemType[] AcceptableItems
		{
			get
			{
				return Base.AcceptableItems;
			}
			set
			{
				Base.AcceptableItems = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseLockerChamber")]
		public static global::LabApi.Features.Wrappers.LockerChamber? Get(global::MapGeneration.Distributors.LockerChamber? baseLockerChamber)
		{
			if (baseLockerChamber == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseLockerChamber, out global::LabApi.Features.Wrappers.LockerChamber value))
			{
				return CreateLockerChamberWrapper(baseLockerChamber);
			}
			return value;
		}

		private static global::LabApi.Features.Wrappers.LockerChamber CreateLockerChamberWrapper(global::MapGeneration.Distributors.LockerChamber baseLockerChamber)
		{
			global::MapGeneration.Distributors.Locker componentInParent = baseLockerChamber.GetComponentInParent<global::MapGeneration.Distributors.Locker>();
			return new global::LabApi.Features.Wrappers.LockerChamber(baseLockerChamber, (global::LabApi.Features.Wrappers.Locker)global::LabApi.Features.Wrappers.Structure.Get(componentInParent), (byte)componentInParent.Chambers.IndexOf<global::MapGeneration.Distributors.LockerChamber>(baseLockerChamber));
		}

		internal LockerChamber(global::MapGeneration.Distributors.LockerChamber baseLockerChamber, global::LabApi.Features.Wrappers.Locker locker, byte id)
		{
			Base = baseLockerChamber;
			Locker = locker;
			Id = id;
			if (locker.CanCache)
			{
				Dictionary.Add(baseLockerChamber, this);
			}
		}

		public void Fill()
		{
			Locker.Base.FillChamber(Base);
			foreach (global::InventorySystem.Items.Pickups.ItemPickupBase item in Base.Content)
			{
				if (item.TryGetComponent<global::UnityEngine.Rigidbody>(out var component))
				{
					component.isKinematic = false;
				}
			}
		}

		public global::System.Collections.Generic.HashSet<global::LabApi.Features.Wrappers.Pickup> GetAllItems()
		{
			global::System.Collections.Generic.HashSet<global::LabApi.Features.Wrappers.Pickup> hashSet = global::NorthwoodLib.Pools.HashSetPool<global::LabApi.Features.Wrappers.Pickup>.Shared.Rent();
			global::InventorySystem.Items.Pickups.ItemPickupBase[] array = Base.Content.ToArray();
			foreach (global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase in array)
			{
				if (itemPickupBase == null)
				{
					Base.Content.Remove(itemPickupBase);
				}
				else
				{
					hashSet.Add(global::LabApi.Features.Wrappers.Pickup.Get(itemPickupBase));
				}
			}
			return hashSet;
		}

		public void RemoveAllItems()
		{
			foreach (global::InventorySystem.Items.Pickups.ItemPickupBase item in Base.Content)
			{
				item.DestroySelf();
			}
			Base.Content.Clear();
			Base.ToBeSpawned.Clear();
		}

		public void RemoveItem(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			Base.Content.Remove(pickup.Base);
			Base.ToBeSpawned.Remove(pickup.Base);
			pickup.Destroy();
		}

		public global::LabApi.Features.Wrappers.Pickup AddItem(ItemType type)
		{
			global::LabApi.Features.Wrappers.Pickup pickup = global::LabApi.Features.Wrappers.Pickup.Create(type, Base.Spawnpoint.position, Base.Spawnpoint.rotation);
			pickup.Transform.SetParent(Base.Spawnpoint);
			Base.Content.Add(pickup.Base);
			(pickup.Base as global::InventorySystem.Items.Pickups.IPickupDistributorTrigger)?.OnDistributed();
			if (!IsOpen)
			{
				pickup.IsLocked = true;
				Base.WasEverOpened = false;
			}
			if (Base.SpawnOnFirstChamberOpening && !IsOpen)
			{
				Base.ToBeSpawned.Add(pickup.Base);
			}
			else
			{
				pickup.Spawn();
			}
			return pickup;
		}

		public void Interact(global::LabApi.Features.Wrappers.Player player)
		{
			if (player == null)
			{
				throw new global::System.ArgumentNullException("player");
			}
			Locker.Base.ServerInteract(player.ReferenceHub, Id);
		}

		public void PlayDeniedSound(global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags permissionUsed)
		{
			Locker.Base.RpcPlayDenied(Id, permissionUsed);
		}

		internal void OnRemove()
		{
			Dictionary.Remove(Base);
		}
	}
}
