using Interactables.Interobjects.DoorUtils;
using InventorySystem;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration.Scenarios;
using Mirror;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class ItemDistributor : SpawnablesDistributorBase
	{
		protected override void PlaceSpawnables()
		{
			while (ItemSpawnpointBase.Instances.Remove(null))
			{
			}
			foreach (DistributorScenario instance in DistributorScenario.Instances)
			{
				instance.SelectProcessors();
			}
			foreach (ItemSpawnpointBase instance2 in ItemSpawnpointBase.Instances)
			{
				if (instance2.SpawnEmptyChance < Random.Range(1, 101))
				{
					ItemPickupBase pickup;
					if (instance2 is IDistributorGenerationResolver distributorGenerationResolver)
					{
						distributorGenerationResolver.Generate(this);
					}
					else if (instance2.TryGeneratePickup(out pickup))
					{
						ServerRegisterPickup(pickup, instance2.TriggerDoorName);
					}
				}
			}
		}

		public static ItemPickupBase ServerCreatePickup(ItemType id, Transform parentRoom)
		{
			if (!InventoryItemLoader.AvailableItems.TryGetValue(id, out var value))
			{
				return null;
			}
			if (value.PickupDropModel == null)
			{
				return null;
			}
			ItemPickupBase itemPickupBase = Object.Instantiate(value.PickupDropModel, parentRoom.position, parentRoom.rotation);
			itemPickupBase.NetworkInfo = new PickupSyncInfo(id, value.Weight, 0);
			itemPickupBase.transform.SetParent(parentRoom);
			return itemPickupBase;
		}

		public void ServerRegisterPickup(ItemPickupBase pickup, string triggerDoor = null)
		{
			ItemSpawningEventArgs e = new ItemSpawningEventArgs(pickup.ItemId.TypeId);
			ServerEvents.OnItemSpawning(e);
			if (e.IsAllowed)
			{
				if (pickup is IPickupDistributorTrigger pickupDistributorTrigger)
				{
					pickupDistributorTrigger.OnDistributed();
				}
				if (string.IsNullOrEmpty(triggerDoor) || !DoorNametagExtension.NamedDoors.TryGetValue(triggerDoor, out var value))
				{
					SpawnPickup(pickup);
				}
				else
				{
					RegisterUnspawnedObject(value.TargetDoor, pickup.gameObject);
				}
				ServerEvents.OnItemSpawned(new ItemSpawnedEventArgs(pickup));
			}
		}

		public static void SpawnPickup(ItemPickupBase ipb)
		{
			if (!(ipb == null))
			{
				NetworkServer.Spawn(ipb.gameObject);
				PickupSyncInfo pickupSyncInfo = new PickupSyncInfo(ipb.Info.ItemId, ipb.Info.WeightKg, 0);
				pickupSyncInfo.Locked = ipb.Info.Locked;
				PickupSyncInfo networkInfo = pickupSyncInfo;
				InitiallySpawnedItems.Singleton.AddInitial(networkInfo.Serial);
				ipb.NetworkInfo = networkInfo;
			}
		}

		protected override void SpawnObject(GameObject objectToSpawn)
		{
			if (objectToSpawn != null && objectToSpawn.TryGetComponent<ItemPickupBase>(out var component))
			{
				SpawnPickup(component);
			}
		}
	}
}
