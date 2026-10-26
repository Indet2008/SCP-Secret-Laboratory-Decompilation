using System;
using System.Collections.Generic;
using System.Linq;
using GameCore;
using Hints;
using InventorySystem.Configs;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.ThrowableProjectiles;
using InventorySystem.Items.Usables.Scp1344;
using InventorySystem.Searching;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.Holidays;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles;
using RoundRestarting;
using UnityEngine;
using UnityEngine.Pool;

namespace InventorySystem
{
	public static class InventoryItemProvider
	{
		public static Action<ReferenceHub, ItemBase> OnItemProvided;

		private static readonly Dictionary<ReferenceHub, List<ItemPickupBase>> PreviousInventoryPickups = new Dictionary<ReferenceHub, List<ItemPickupBase>>();

		private static readonly Queue<ReferenceHub> InventoriesToReplenish = new Queue<ReferenceHub>();

		private static readonly bool KeepItemsAfterEscaping = ConfigFile.ServerConfig.GetBool("keep_items_after_escaping", def: true);

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnRoleChanged += RoleChanged;
			StaticUnityMethods.OnUpdate += Update;
		}

		private static void Update()
		{
			if (NetworkServer.active && InventoriesToReplenish.TryDequeue(out var result) && !(result == null))
			{
				SpawnPreviousInventoryPickups(result);
			}
		}

		public static void ServerGrantLoadout(ReferenceHub target, PlayerRoleBase role, bool resetInventory = true)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerGrantLoadout can only be executed on the server.");
			}
			if (RoundRestart.IsRoundRestarting)
			{
				return;
			}
			Inventory inventory = target.inventory;
			List<ItemType> items = NorthwoodLib.Pools.ListPool<ItemType>.Shared.Rent();
			Dictionary<ItemType, ushort> ammo = CollectionPool<Dictionary<ItemType, ushort>, KeyValuePair<ItemType, ushort>>.Get();
			TryAssignLoadout(role, ref items, ref ammo);
			PlayerReceivingLoadoutEventArgs e = new PlayerReceivingLoadoutEventArgs(target, items, ammo, resetInventory);
			PlayerEvents.OnReceivingLoadout(e);
			if (!e.IsAllowed)
			{
				NorthwoodLib.Pools.ListPool<ItemType>.Shared.Return(items);
				CollectionPool<Dictionary<ItemType, ushort>, KeyValuePair<ItemType, ushort>>.Release(ammo);
				return;
			}
			if (resetInventory)
			{
				while (inventory.UserInventory.Items.Count > 0)
				{
					inventory.ServerRemoveItem(inventory.UserInventory.Items.ElementAt(0).Key, null);
				}
				inventory.UserInventory.ReserveAmmo.Clear();
				inventory.SendAmmoNextFrame = true;
			}
			foreach (KeyValuePair<ItemType, ushort> item in ammo)
			{
				inventory.ServerAddAmmo(item.Key, item.Value);
			}
			for (int i = 0; i < items.Count; i++)
			{
				ItemBase arg = inventory.ServerAddItem(items[i], ItemAddReason.StartingItem, 0);
				OnItemProvided?.Invoke(target, arg);
			}
			PlayerEvents.OnReceivedLoadout(new PlayerReceivedLoadoutEventArgs(target, items, ammo, resetInventory));
			NorthwoodLib.Pools.ListPool<ItemType>.Shared.Return(items);
			CollectionPool<Dictionary<ItemType, ushort>, KeyValuePair<ItemType, ushort>>.Release(ammo);
		}

		private static bool TryAssignLoadout(PlayerRoleBase role, ref List<ItemType> items, ref Dictionary<ItemType, ushort> ammo)
		{
			if (!TryGetLoadout(role.RoleTypeId, out var ammo2, out var items2))
			{
				return false;
			}
			ItemType[] array = items2;
			foreach (ItemType itemType in array)
			{
				if (HolidayUtils.IsHolidayActive(HolidayType.Halloween) && itemType == ItemType.Flashlight)
				{
					items.Add(ItemType.Lantern);
				}
				else
				{
					items.Add(itemType);
				}
			}
			foreach (KeyValuePair<ItemType, ushort> item in ammo2)
			{
				ammo.Add(item.Key, item.Value);
			}
			return true;
		}

		private static bool TryGetLoadout(RoleTypeId role, out Dictionary<ItemType, ushort> ammo, out ItemType[] items)
		{
			if (!StartingInventories.DefinedInventories.TryGetValue(role, out var value))
			{
				ammo = null;
				items = null;
				return false;
			}
			ammo = value.Ammo;
			items = value.Items;
			return true;
		}

		private static void SpawnPreviousInventoryPickups(ReferenceHub hub)
		{
			if (!PreviousInventoryPickups.TryGetValue(hub, out var value))
			{
				return;
			}
			NetworkConnection connectionToClient = hub.connectionToClient;
			hub.transform.position = hub.transform.position;
			bool flag = HintDisplay.SuppressedReceivers.Add(connectionToClient);
			foreach (ItemPickupBase item in value)
			{
				if (!(item == null) && !item.Info.Locked)
				{
					PickupSearchCompletor pickupSearchCompletor = item.GetPickupSearchCompletor(hub.searchCoordinator, float.MaxValue);
					if (pickupSearchCompletor.AllowPickupUponEscape && pickupSearchCompletor.ValidateStart())
					{
						pickupSearchCompletor.Complete();
					}
					else
					{
						item.transform.position = hub.transform.position;
					}
				}
			}
			PreviousInventoryPickups.Remove(hub);
			if (flag)
			{
				HintDisplay.SuppressedReceivers.Remove(connectionToClient);
			}
		}

		private static void RoleChanged(ReferenceHub ply, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!NetworkServer.active || !newRole.ServerSpawnFlags.HasFlag(RoleSpawnFlags.AssignInventory))
			{
				return;
			}
			Inventory inventory = ply.inventory;
			bool flag = KeepItemsAfterEscaping && newRole.ServerSpawnReason == RoleChangeReason.Escaped;
			if (flag)
			{
				List<ItemPickupBase> list = new List<ItemPickupBase>();
				HashSet<ushort> hashSet = NorthwoodLib.Pools.HashSetPool<ushort>.Shared.Rent();
				foreach (var (item, itemBase2) in inventory.UserInventory.Items)
				{
					if (itemBase2 is Scp1344Item scp1344Item)
					{
						scp1344Item.Status = Scp1344Status.Idle;
					}
					else if (!(itemBase2 is ThrowableItem { PendingRemoval: not false }))
					{
						hashSet.Add(item);
					}
				}
				foreach (ushort item2 in hashSet)
				{
					list.Add(inventory.ServerDropItem(item2));
				}
				NorthwoodLib.Pools.HashSetPool<ushort>.Shared.Return(hashSet);
				PreviousInventoryPickups[ply] = list;
			}
			ServerGrantLoadout(ply, newRole, !flag);
			InventoriesToReplenish.Enqueue(ply);
		}
	}
}
