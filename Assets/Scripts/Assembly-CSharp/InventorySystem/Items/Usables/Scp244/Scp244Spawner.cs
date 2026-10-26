using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using MapGeneration;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public static class Scp244Spawner
	{
		private static readonly List<RoomIdentifier> CompatibleRooms = new List<RoomIdentifier>();

		private const int Amount = 1;

		private const float SpawnChance = 0.35f;

		private static readonly Dictionary<RoomName, Vector3> NameToPos = new Dictionary<RoomName, Vector3>
		{
			[RoomName.Unnamed] = Vector3.up,
			[RoomName.HczWarhead] = new Vector3(6.8f, 401f, 11.6f),
			[RoomName.HczMicroHID] = new Vector3(-7.4f, 1f, -6.8f),
			[RoomName.HczArmory] = new Vector3(-3.8f, 1f, 0.8f),
			[RoomName.HczTestroom] = new Vector3(0f, 0.26f, 7f)
		};

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			NetIdWaypoint.OnNetIdWaypointsSet += SpawnAllInstances;
		}

		private static void SpawnAllInstances()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			CompatibleRooms.Clear();
			if (!InventoryItemLoader.AvailableItems.TryGetValue(ItemType.SCP244b, out var value))
			{
				return;
			}
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if (allRoomIdentifier != null && allRoomIdentifier.Zone == FacilityZone.HeavyContainment && NameToPos.ContainsKey(allRoomIdentifier.Name))
				{
					CompatibleRooms.Add(allRoomIdentifier);
				}
			}
			for (int i = 0; i < 1; i++)
			{
				SpawnScp244(value);
			}
		}

		private static void SpawnScp244(ItemBase ib)
		{
			if (CompatibleRooms.Count != 0 && !(Random.value > 0.35f))
			{
				int index = Random.Range(0, CompatibleRooms.Count);
				Vector3 position = CompatibleRooms[index].transform.TransformPoint(NameToPos[CompatibleRooms[index].Name]);
				ItemPickupBase itemPickupBase = Object.Instantiate(ib.PickupDropModel, position, Quaternion.identity);
				itemPickupBase.NetworkInfo = new PickupSyncInfo
				{
					ItemId = ib.ItemTypeId,
					WeightKg = ib.Weight,
					Serial = ItemSerialGenerator.GenerateNext()
				};
				if (itemPickupBase is Scp244DeployablePickup scp244DeployablePickup)
				{
					scp244DeployablePickup.State = Scp244State.Active;
				}
				NetworkServer.Spawn(itemPickupBase.gameObject);
				CompatibleRooms.RemoveAt(index);
			}
		}
	}
}
