using System;
using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Armor;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.Scp914Events;
using LabApi.Events.Handlers;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using Scp914.Processors;
using UnityEngine;

namespace Scp914
{
	public static class Scp914Upgrader
	{
		public static int SolidObjectMask;

		public static Action<ItemPickupBase, Scp914KnobSetting> OnPickupUpgraded = (ItemPickupBase targetPickup, Scp914KnobSetting usedMode) =>
		{
		};

		public static Action<ItemBase, Scp914KnobSetting> OnInventoryItemUpgraded = (ItemBase targetItem, Scp914KnobSetting usedMode) =>
		{
		};

		public static event Action<Scp914Result, Scp914KnobSetting> OnUpgraded;

		public static void Upgrade(Collider[] intake, Scp914Mode mode, Scp914KnobSetting setting)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Scp914Upgrader.Upgrade is a serverside-only script.");
			}
			HashSet<GameObject> hashSet = HashSetPool<GameObject>.Shared.Rent();
			bool upgradeDropped = (mode & Scp914Mode.Dropped) == Scp914Mode.Dropped;
			bool flag = (mode & Scp914Mode.Inventory) == Scp914Mode.Inventory;
			bool heldOnly = flag && (mode & Scp914Mode.Held) == Scp914Mode.Held;
			for (int i = 0; i < intake.Length; i++)
			{
				GameObject gameObject = intake[i].transform.root.gameObject;
				if (hashSet.Add(gameObject))
				{
					ItemPickupBase component;
					if (ReferenceHub.TryGetHub(gameObject, out var hub))
					{
						ProcessPlayer(hub, flag, heldOnly, setting);
					}
					else if (gameObject.TryGetComponent<ItemPickupBase>(out component))
					{
						ProcessPickup(component, upgradeDropped, setting);
					}
				}
			}
			HashSetPool<GameObject>.Shared.Return(hashSet);
		}

		private static void ProcessPlayer(ReferenceHub ply, bool upgradeInventory, bool heldOnly, Scp914KnobSetting setting)
		{
			if (Physics.Linecast(ply.transform.position, Scp914Controller.Singleton.IntakeChamber.position, SolidObjectMask))
			{
				return;
			}
			Vector3 newPosition = ply.transform.position + Scp914Controller.MoveVector;
			Scp914ProcessingPlayerEventArgs e = new Scp914ProcessingPlayerEventArgs(newPosition, setting, ply);
			Scp914Events.OnProcessingPlayer(e);
			if (!e.IsAllowed)
			{
				return;
			}
			setting = e.KnobSetting;
			newPosition = e.NewPosition;
			ply.TryOverridePosition(newPosition);
			if (!upgradeInventory)
			{
				return;
			}
			HashSet<ushort> hashSet = HashSetPool<ushort>.Shared.Rent();
			foreach (KeyValuePair<ushort, ItemBase> item in ply.inventory.UserInventory.Items)
			{
				if (!heldOnly || item.Key == ply.inventory.CurItem.SerialNumber)
				{
					hashSet.Add(item.Key);
				}
			}
			foreach (ushort item2 in hashSet)
			{
				if (!ply.inventory.UserInventory.Items.TryGetValue(item2, out var value) || !TryGetProcessor(value.ItemTypeId, out var processor))
				{
					continue;
				}
				ItemType itemTypeId = value.ItemTypeId;
				Scp914ProcessingInventoryItemEventArgs e2 = new Scp914ProcessingInventoryItemEventArgs(value, setting, ply);
				Scp914Events.OnProcessingInventoryItem(e2);
				if (e2.IsAllowed)
				{
					setting = e2.KnobSetting;
					OnInventoryItemUpgraded?.Invoke(value, setting);
					Scp914Result arg = processor.UpgradeInventoryItem(setting, value);
					OnUpgraded?.Invoke(arg, setting);
					if (arg.ResultingItems == null || !arg.ResultingItems.TryGet(0, out var element))
					{
						element = null;
					}
					if (element != null)
					{
						Scp914Events.OnProcessedInventoryItem(new Scp914ProcessedInventoryItemEventArgs(itemTypeId, element, setting, ply));
					}
				}
			}
			HashSetPool<ushort>.Shared.Return(hashSet);
			BodyArmorUtils.SetPlayerDirty(ply);
			Scp914Events.OnProcessedPlayer(new Scp914ProcessedPlayerEventArgs(newPosition, setting, ply));
		}

		private static void ProcessPickup(ItemPickupBase pickup, bool upgradeDropped, Scp914KnobSetting setting)
		{
			if (!(!pickup.Info.Locked & upgradeDropped) || !TryGetProcessor(pickup.Info.ItemId, out var processor))
			{
				return;
			}
			Vector3 newPosition = pickup.transform.position + Scp914Controller.MoveVector;
			ItemType itemId = pickup.Info.ItemId;
			Scp914ProcessingPickupEventArgs e = new Scp914ProcessingPickupEventArgs(newPosition, setting, pickup);
			Scp914Events.OnProcessingPickup(e);
			if (e.IsAllowed)
			{
				newPosition = e.NewPosition;
				setting = e.KnobSetting;
				OnPickupUpgraded?.Invoke(pickup, setting);
				Scp914Result arg = processor.UpgradePickup(setting, pickup);
				OnUpgraded?.Invoke(arg, setting);
				if (arg.ResultingPickups == null || !arg.ResultingPickups.TryGet(0, out var element))
				{
					element = null;
				}
				Scp914Events.OnProcessedPickup(new Scp914ProcessedPickupEventArgs(itemId, newPosition, setting, element));
			}
		}

		private static bool TryGetProcessor(ItemType itemType, out Scp914ItemProcessor processor)
		{
			if (InventoryItemLoader.AvailableItems.TryGetValue(itemType, out var value) && value.TryGetComponent<Scp914ItemProcessor>(out processor))
			{
				return true;
			}
			processor = null;
			return false;
		}
	}
}
