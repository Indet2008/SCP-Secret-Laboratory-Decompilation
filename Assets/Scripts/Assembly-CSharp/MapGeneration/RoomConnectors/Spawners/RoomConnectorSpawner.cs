using System;
using System.Collections.Generic;

namespace MapGeneration.RoomConnectors.Spawners
{
	public static class RoomConnectorSpawner
	{
		private readonly struct SpawnpointWeightPair
		{
			public readonly float Weight;

			public readonly RoomConnectorSpawnpointBase Spawnpoint;

			public SpawnpointWeightPair(RoomConnectorSpawnpointBase sp, SpawnableRoomConnectorType type)
			{
				Spawnpoint = sp;
				Weight = sp.GetSpawnChanceWeight(type);
			}
		}

		private static readonly List<SpawnpointWeightPair> CompatibleNonAlloc = new List<SpawnpointWeightPair>();

		public static void ServerSpawnAllConnectors(HashSet<RoomConnectorSpawnpointBase> readyToSpawn)
		{
			Random rng = new Random(SeedSynchronizer.Seed);
			Queue<SpawnableRoomConnectorType> queue = GenerateSpawnQueue(GenerateCompatibleSpawnpointCounts(readyToSpawn), rng);
			List<int> allPriorities = GetAllPriorities(readyToSpawn);
			SpawnableRoomConnectorType result;
			while (queue.TryDequeue(out result))
			{
				TrySpawnConnector(result, allPriorities, readyToSpawn, rng);
			}
			foreach (RoomConnectorSpawnpointBase item in readyToSpawn)
			{
				item.SpawnFallback();
			}
		}

		private static bool TrySpawnConnector(SpawnableRoomConnectorType type, List<int> priorities, HashSet<RoomConnectorSpawnpointBase> remainingSpawnpoints, Random rng)
		{
			bool flag = false;
			RoomConnectorSpawnpointBase result = null;
			foreach (int priority in priorities)
			{
				if (TryGetRandomSpawnpointForPriority(type, priority, remainingSpawnpoints, rng, out result))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
			result.Spawn(type);
			remainingSpawnpoints.Remove(result);
			return true;
		}

		private static bool TryGetRandomSpawnpointForPriority(SpawnableRoomConnectorType type, int priority, HashSet<RoomConnectorSpawnpointBase> remainingSpawnpoints, Random rng, out RoomConnectorSpawnpointBase result)
		{
			CompatibleNonAlloc.Clear();
			double num = 0.0;
			foreach (RoomConnectorSpawnpointBase remainingSpawnpoint in remainingSpawnpoints)
			{
				if (remainingSpawnpoint.SpawnPriority == priority)
				{
					SpawnpointWeightPair item = new SpawnpointWeightPair(remainingSpawnpoint, type);
					if (!(item.Weight <= 0f))
					{
						num += (double)item.Weight;
						CompatibleNonAlloc.Add(item);
					}
				}
			}
			if (CompatibleNonAlloc.Count == 0)
			{
				result = null;
				return false;
			}
			double num2 = rng.NextDouble() * num;
			double num3 = 0.0;
			foreach (SpawnpointWeightPair item2 in CompatibleNonAlloc)
			{
				num3 += (double)item2.Weight;
				if (!(num2 > num3))
				{
					result = item2.Spawnpoint;
					return true;
				}
			}
			result = null;
			return false;
		}

		private static List<int> GetAllPriorities(HashSet<RoomConnectorSpawnpointBase> connectors)
		{
			List<int> list = new List<int>();
			foreach (RoomConnectorSpawnpointBase connector in connectors)
			{
				int spawnPriority = connector.SpawnPriority;
				if (list.Contains(spawnPriority))
				{
					continue;
				}
				bool flag = false;
				for (int i = 0; i < list.Count; i++)
				{
					if (spawnPriority > list[i])
					{
						list.Insert(i, spawnPriority);
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					list.Add(spawnPriority);
				}
			}
			return list;
		}

		private static Queue<SpawnableRoomConnectorType> GenerateSpawnQueue(Dictionary<SpawnableRoomConnectorType, int> spawnpointCounts, Random rng)
		{
			Queue<SpawnableRoomConnectorType> queue = new Queue<SpawnableRoomConnectorType>();
			foreach (SpawnableRoomConnector registeredConnector in RoomConnectorDistributorSettings.RegisteredConnectors)
			{
				RoomConnectorSpawnData spawnData = registeredConnector.SpawnData;
				int valueOrDefault = spawnpointCounts.GetValueOrDefault(spawnData.ConnectorType);
				int required = spawnData.GetRequired(valueOrDefault);
				for (int i = 0; i < required; i++)
				{
					queue.Enqueue(spawnData.ConnectorType);
				}
			}
			List<SpawnableRoomConnectorType> list = new List<SpawnableRoomConnectorType>();
			foreach (SpawnableRoomConnector registeredConnector2 in RoomConnectorDistributorSettings.RegisteredConnectors)
			{
				RoomConnectorSpawnData spawnData2 = registeredConnector2.SpawnData;
				int valueOrDefault2 = spawnpointCounts.GetValueOrDefault(spawnData2.ConnectorType);
				int optional = spawnData2.GetOptional(valueOrDefault2);
				for (int j = 0; j < optional; j++)
				{
					list.Add(spawnData2.ConnectorType);
				}
			}
			list.ShuffleList(rng);
			list.ForEach(queue.Enqueue);
			return queue;
		}

		private static Dictionary<SpawnableRoomConnectorType, int> GenerateCompatibleSpawnpointCounts(HashSet<RoomConnectorSpawnpointBase> allSpawnpoints)
		{
			Dictionary<SpawnableRoomConnectorType, int> dictionary = new Dictionary<SpawnableRoomConnectorType, int>();
			foreach (RoomConnectorSpawnpointBase allSpawnpoint in allSpawnpoints)
			{
				SpawnableRoomConnectorType[] values = EnumUtils<SpawnableRoomConnectorType>.Values;
				foreach (SpawnableRoomConnectorType spawnableRoomConnectorType in values)
				{
					if (!(allSpawnpoint.GetSpawnChanceWeight(spawnableRoomConnectorType) <= 0f))
					{
						if (dictionary.TryGetValue(spawnableRoomConnectorType, out var value))
						{
							dictionary[spawnableRoomConnectorType] = value + 1;
						}
						else
						{
							dictionary.Add(spawnableRoomConnectorType, 1);
						}
					}
				}
			}
			return dictionary;
		}
	}
}
