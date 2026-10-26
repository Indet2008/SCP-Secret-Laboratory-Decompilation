using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using NorthwoodLib.Pools;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class StructureDistributor : SpawnablesDistributorBase
	{
		private readonly Queue<int> _queuedStructures = new Queue<int>();

		private readonly HashSet<int> _missingSpawnpoints = new HashSet<int>();

		protected override void PlaceSpawnables()
		{
			PrepareQueueForStructures();
			int structureId;
			StructureSpawnpoint spawnpoint;
			while (TryGetNextStructure(out structureId, out spawnpoint))
			{
				if (!(spawnpoint == null))
				{
					SpawnStructure(Settings.SpawnableStructures[structureId], spawnpoint.transform, spawnpoint.TriggerDoorName);
				}
			}
		}

		private void PrepareQueueForStructures()
		{
			List<int> list = ListPool<int>.Shared.Rent();
			for (int i = 0; i < Settings.SpawnableStructures.Length; i++)
			{
				float time = Random.Range(0f, 1f);
				int num = Mathf.FloorToInt(Settings.SpawnableStructures[i].MinMaxProbability.Evaluate(time));
				for (int j = 0; j < num; j++)
				{
					if (j < Settings.SpawnableStructures[i].MinAmount)
					{
						_queuedStructures.Enqueue(i);
					}
					else
					{
						list.Add(i);
					}
				}
			}
			while (list.Count > 0)
			{
				int index = Random.Range(0, list.Count);
				_queuedStructures.Enqueue(list[index]);
				list.RemoveAt(index);
			}
			ListPool<int>.Shared.Return(list);
		}

		private bool TryGetNextStructure(out int structureId, out StructureSpawnpoint spawnpoint)
		{
			spawnpoint = null;
			if (!_queuedStructures.TryDequeue(out structureId))
			{
				return false;
			}
			if (_missingSpawnpoints.Contains(structureId))
			{
				return true;
			}
			List<StructureSpawnpoint> list = ListPool<StructureSpawnpoint>.Shared.Rent();
			foreach (StructureSpawnpoint availableInstance in StructureSpawnpoint.AvailableInstances)
			{
				if (!(availableInstance == null) && availableInstance.CompatibleStructures.Contains(Settings.SpawnableStructures[structureId].StructureType))
				{
					list.Add(availableInstance);
				}
			}
			if (list.Count > 0)
			{
				StructureSpawnpoint structureSpawnpoint = list[Random.Range(0, list.Count)];
				StructureSpawnpoint.AvailableInstances.Remove(structureSpawnpoint);
				spawnpoint = structureSpawnpoint;
			}
			else
			{
				_missingSpawnpoints.Add(structureId);
			}
			return true;
		}

		private void SpawnStructure(SpawnableStructure structure, Transform tr, string doorName)
		{
			SpawnableStructure spawnableStructure = Object.Instantiate(structure, tr.position, tr.rotation);
			spawnableStructure.transform.SetParent(tr);
			if (string.IsNullOrEmpty(doorName) || !DoorNametagExtension.NamedDoors.TryGetValue(doorName, out var value))
			{
				SpawnObject(spawnableStructure.gameObject);
			}
			else
			{
				RegisterUnspawnedObject(value.TargetDoor, spawnableStructure.gameObject);
			}
		}
	}
}
