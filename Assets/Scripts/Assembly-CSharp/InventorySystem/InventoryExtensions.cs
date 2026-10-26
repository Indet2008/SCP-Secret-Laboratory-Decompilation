using System;
using System.Collections.Generic;
using InventorySystem.Items;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.Usables.Scp330;
using InventorySystem.Searching;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem
{
	public static class InventoryExtensions
	{
		public static event Action<ReferenceHub, ItemBase, ItemPickupBase> OnItemAdded;

		public static event Action<ReferenceHub, ItemBase, ItemPickupBase> OnItemRemoved;

		public static event Action<ReferenceHub> OnInventoryDropped;

		public static ItemType GetSelectedItemType(this Inventory inv)
		{
			if (inv.CurItem.SerialNumber <= 0)
			{
				return ItemType.None;
			}
			return inv.CurItem.TypeId;
		}

		public static bool TryGetHubHoldingSerial(ushort serial, out ReferenceHub hub)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.inventory.CurItem.SerialNumber == serial)
				{
					hub = allHub;
					return true;
				}
			}
			hub = null;
			return false;
		}

		public static bool ServerTryGetItemWithSerial(ushort serial, out ItemBase ib)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerTryGetItemWithSerial can only be executed on the server.");
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.inventory.UserInventory.Items.TryGetValue(serial, out ib))
				{
					return true;
				}
			}
			ib = null;
			return false;
		}

		public static ItemBase ServerAddItem(this Inventory inv, ItemType type, ItemAddReason addReason, ushort itemSerial = 0, ItemPickupBase pickup = null)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerAddItem can only be executed on the server.");
			}
			if (inv.UserInventory.Items.Count >= 8 && InventoryItemLoader.AvailableItems.TryGetValue(type, out var value) && value.Category != ItemCategory.Ammo)
			{
				return null;
			}
			if (itemSerial == 0)
			{
				itemSerial = ItemSerialGenerator.GenerateNext();
			}
			ItemBase itemBase = inv.CreateItemInstance(new ItemIdentifier(type, itemSerial), inv.isLocalPlayer);
			if (itemBase == null)
			{
				return null;
			}
			inv.UserInventory.Items[itemSerial] = itemBase;
			itemBase.ServerAddReason = addReason;
			itemBase.OnAdded(pickup);
			OnItemAdded?.Invoke(inv._hub, itemBase, pickup);
			if (inv.isLocalPlayer && itemBase is IAcquisitionConfirmationTrigger acquisitionConfirmationTrigger)
			{
				acquisitionConfirmationTrigger.ServerConfirmAcqusition();
				acquisitionConfirmationTrigger.AcquisitionAlreadyReceived = true;
			}
			inv.SendItemsNextFrame = true;
			return itemBase;
		}

		public static void ServerRemoveItem(this Inventory inv, ushort itemSerial, ItemPickupBase ipb)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerRemoveItem can only be executed on the server.");
			}
			if (inv.DestroyItemInstance(itemSerial, ipb, out var foundItem))
			{
				if (itemSerial == inv.CurItem.SerialNumber)
				{
					inv.NetworkCurItem = ItemIdentifier.None;
				}
				inv.UserInventory.Items.Remove(itemSerial);
				inv.SendItemsNextFrame = true;
				OnItemRemoved?.Invoke(inv._hub, foundItem, ipb);
			}
		}

		public static ItemPickupBase ServerDropItem(this Inventory inv, ushort itemSerial)
		{
			if (!inv.UserInventory.Items.TryGetValue(itemSerial, out var value))
			{
				return null;
			}
			return value.ServerDropItem(spawn: true);
		}

		public static void ServerDropEverything(this Inventory inv)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerDropEverything can only be executed on the server.");
			}
			OnInventoryDropped?.Invoke(inv._hub);
			HashSet<ItemType> hashSet = HashSetPool<ItemType>.Shared.Rent();
			foreach (KeyValuePair<ItemType, ushort> item in inv.UserInventory.ReserveAmmo)
			{
				if (item.Value > 0)
				{
					hashSet.Add(item.Key);
				}
			}
			foreach (ItemType item2 in hashSet)
			{
				inv.ServerDropAmmo(item2, ushort.MaxValue);
			}
			HashSetPool<ItemType>.Shared.Return(hashSet);
			HashSet<ushort> hashSet2 = HashSetPool<ushort>.Shared.Rent();
			foreach (ushort key in inv.UserInventory.Items.Keys)
			{
				hashSet2.Add(key);
			}
			foreach (ushort item3 in hashSet2)
			{
				inv.ServerDropItem(item3);
			}
			HashSetPool<ushort>.Shared.Return(hashSet2);
		}

		public static List<AmmoPickup> ServerDropAmmo(this Inventory inv, ItemType ammoType, ushort amount, bool checkMinimals = false)
		{
			List<AmmoPickup> list = new List<AmmoPickup>();
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerDropAmmo can only be executed on the server.");
			}
			if (inv.UserInventory.ReserveAmmo.TryGetValue(ammoType, out var value) && InventoryItemLoader.AvailableItems.TryGetValue(ammoType, out var value2))
			{
				if (value2.PickupDropModel == null)
				{
					Debug.LogError("No pickup drop model set. Could not drop the ammo.");
					return list;
				}
				if (checkMinimals && value2.PickupDropModel is AmmoPickup ammoPickup)
				{
					int num = Mathf.FloorToInt((float)(int)ammoPickup.SavedAmmo / 2f);
					if (amount < num && value > num)
					{
						amount = (ushort)num;
					}
				}
				int num2 = Mathf.Min(amount, value);
				PlayerDroppingAmmoEventArgs e = new PlayerDroppingAmmoEventArgs(inv._hub, ammoType, num2);
				PlayerEvents.OnDroppingAmmo(e);
				if (!e.IsAllowed)
				{
					return list;
				}
				inv.UserInventory.ReserveAmmo[ammoType] = (ushort)(value - num2);
				inv.SendAmmoNextFrame = true;
				while (num2 > 0)
				{
					if (ServerCreatePickup(psi: new PickupSyncInfo(ammoType, value2.Weight, 0), inv: inv, item: value2) is AmmoPickup ammoPickup2)
					{
						list.Add(ammoPickup2);
						ushort num3 = (ushort)Mathf.Min(ammoPickup2.MaxAmmo, num2);
						PlayerEvents.OnDroppedAmmo(new PlayerDroppedAmmoEventArgs(inv._hub, ammoType, num3, ammoPickup2));
						ammoPickup2.NetworkSavedAmmo = num3;
						num2 -= ammoPickup2.SavedAmmo;
					}
					else
					{
						num2--;
					}
				}
				return list;
			}
			return list;
		}

		public static ItemPickupBase ServerCreatePickup(this Inventory inv, ItemBase item, PickupSyncInfo? psi, bool spawn = true, Action<ItemPickupBase> setupMethod = null)
		{
			Quaternion rotation = ReferenceHub.GetHub(inv.gameObject).PlayerCameraReference.rotation;
			Quaternion rotation2 = item.PickupDropModel.transform.rotation;
			return ServerCreatePickup(item, psi, inv.transform.position, rotation * rotation2, spawn, setupMethod);
		}

		public static ItemPickupBase ServerCreatePickup(ItemBase item, PickupSyncInfo? psi, Vector3 position, bool spawn = true, Action<ItemPickupBase> setupMethod = null)
		{
			return ServerCreatePickup(item, psi, position, item.PickupDropModel.transform.rotation, spawn, setupMethod);
		}

		public static ItemPickupBase ServerCreatePickup(ItemBase item, PickupSyncInfo? psi, Vector3 position, Quaternion rotation, bool spawn = true, Action<ItemPickupBase> setupMethod = null)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerCreatePickup can only be executed on the server.");
			}
			PickupSyncInfo valueOrDefault = psi.GetValueOrDefault();
			if (!psi.HasValue)
			{
				valueOrDefault = new PickupSyncInfo
				{
					ItemId = item.ItemTypeId,
					Serial = ItemSerialGenerator.GenerateNext(),
					WeightKg = item.Weight
				};
				psi = valueOrDefault;
			}
			ItemPickupBase itemPickupBase = UnityEngine.Object.Instantiate(item.PickupDropModel, position, rotation);
			itemPickupBase.NetworkInfo = psi.Value;
			setupMethod?.Invoke(itemPickupBase);
			if (spawn)
			{
				NetworkServer.Spawn(itemPickupBase.gameObject);
			}
			return itemPickupBase;
		}

		public static bool ServerAddOrDrop(this Inventory inv, ItemBase item, PickupSyncInfo psi, out ItemPickupBase ipb)
		{
			ipb = inv.ServerCreatePickup(item, psi, spawn: false);
			ISearchCompletor searchCompletor = ipb.GetSearchCompletor(inv._hub.searchCoordinator, float.MaxValue);
			if (searchCompletor.ValidateStart())
			{
				searchCompletor.Complete();
				return true;
			}
			NetworkServer.Spawn(ipb.gameObject);
			return false;
		}

		public static ushort GetCurAmmo(this Inventory inv, ItemType ammoType)
		{
			if (!inv.UserInventory.ReserveAmmo.TryGetValue(ammoType, out var value))
			{
				return 0;
			}
			return value;
		}

		public static void ServerSetAmmo(this Inventory inv, ItemType ammoType, int amount)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerSetAmmo can only be executed on the server.");
			}
			amount = Mathf.Clamp(amount, 0, 65535);
			inv.UserInventory.ReserveAmmo[ammoType] = (ushort)amount;
			inv.SendAmmoNextFrame = true;
		}

		public static void ServerAddAmmo(this Inventory inv, ItemType ammoType, int amountToAdd)
		{
			if (ammoType != ItemType.None)
			{
				if (!NetworkServer.active)
				{
					throw new InvalidOperationException("Method ServerAddAmmo can only be executed on the server.");
				}
				inv.ServerSetAmmo(ammoType, inv.GetCurAmmo(ammoType) + amountToAdd);
			}
		}

		public static bool TryGetInventoryItem(this Inventory inv, ItemType it, out ItemBase ib)
		{
			foreach (KeyValuePair<ushort, ItemBase> item in inv.UserInventory.Items)
			{
				if (item.Value.ItemTypeId == it)
				{
					ib = item.Value;
					return true;
				}
			}
			ib = null;
			return false;
		}

		public static bool TryGetTemplate<T>(this ItemType itemType, out T item) where T : ItemBase
		{
			return InventoryItemLoader.TryGetItem<T>(itemType, out item);
		}

		public static bool TryGetTemplate<T>(this ItemIdentifier itemId, out T item) where T : ItemBase
		{
			return itemId.TypeId.TryGetTemplate<T>(out item);
		}

		public static bool TryGetTemplate<T>(this IIdentifierProvider idProvider, out T item) where T : ItemBase
		{
			return idProvider.ItemId.TryGetTemplate<T>(out item);
		}

		public static T GetTemplate<T>(this ItemType itemType) where T : ItemBase
		{
			if (!InventoryItemLoader.TryGetItem<T>(itemType, out var result))
			{
				return null;
			}
			return result;
		}

		public static ItemBase GetTemplate(this ItemType itemType)
		{
			return InventoryItemLoader.AvailableItems.GetValueOrDefault(itemType);
		}

		public static Scp330Bag GrantCandy(this ReferenceHub hub, CandyKindID candyId, ItemAddReason itemAddReason)
		{
			bool flag = false;
			if (!Scp330Bag.TryGetBag(hub, out var bag))
			{
				bag = hub.inventory.ServerAddItem(ItemType.SCP330, itemAddReason, 0) as Scp330Bag;
				flag = true;
			}
			if (bag == null)
			{
				return null;
			}
			if (flag)
			{
				bag.Candies = new List<CandyKindID> { candyId };
				bag.ServerRefreshBag();
			}
			else if (bag.TryAddSpecific(candyId))
			{
				bag.ServerRefreshBag();
			}
			return bag;
		}
	}
}
