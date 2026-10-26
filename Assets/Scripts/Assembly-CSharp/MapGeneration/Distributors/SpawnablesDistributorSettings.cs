using System;
using FastResources;
using Mirror;
using UnityEngine;

namespace MapGeneration.Distributors
{
	[CreateAssetMenu(fileName = "New Spawner Settings Preset", menuName = "ScriptableObject/Map Generation/Spawnable Elements Settings")]
	public class SpawnablesDistributorSettings : ScriptableObject
	{
		[Range(0.05f, 5f)]
		public float SpawnerDelay;

		[Range(0.05f, 5f)]
		public float UnfreezeDelay;

		public SpawnableStructure[] SpawnableStructures;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += RegisterSpawnables;
		}

		private static void RegisterSpawnables()
		{
			ReadOnlySpan<SpawnablesDistributorSettings> all = FastResourcesDatabase.GetAll<SpawnablesDistributorSettings>();
			for (int i = 0; i < all.Length; i++)
			{
				SpawnableStructure[] spawnableStructures = all[i].SpawnableStructures;
				for (int j = 0; j < spawnableStructures.Length; j++)
				{
					NetworkIdentity netIdentity = spawnableStructures[j].netIdentity;
					NetworkClient.prefabs[netIdentity.assetId] = netIdentity.gameObject;
				}
			}
		}
	}
}
