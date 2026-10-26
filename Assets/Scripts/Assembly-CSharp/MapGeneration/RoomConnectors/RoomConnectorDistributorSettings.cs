using System.Collections.Generic;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace MapGeneration.RoomConnectors
{
	[CreateAssetMenu(fileName = "New Connector Distributor Settings Preset", menuName = "ScriptableObject/Map Generation/Connector Distributor Settings")]
	public class RoomConnectorDistributorSettings : ScriptableObject
	{
		public static readonly List<SpawnableRoomConnector> RegisteredConnectors = new List<SpawnableRoomConnector>();

		public SpawnableRoomConnector[] SpawnableConnectors;

		public static bool TryGetTemplate(SpawnableRoomConnectorType type, out SpawnableRoomConnector result)
		{
			foreach (SpawnableRoomConnector registeredConnector in RegisteredConnectors)
			{
				if (registeredConnector.SpawnData.ConnectorType == type)
				{
					result = registeredConnector;
					return true;
				}
			}
			result = null;
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			LoadSettingsFromResources();
			CustomNetworkManager.OnClientStarted += RegisterSpawnables;
		}

		private static void LoadSettingsFromResources()
		{
			RoomConnectorDistributorSettings[] array = Resources.LoadAll<RoomConnectorDistributorSettings>(string.Empty);
			RegisteredConnectors.Clear();
			RoomConnectorDistributorSettings[] array2 = array;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].RegisterAll();
			}
		}

		private static void RegisterSpawnables()
		{
			foreach (SpawnableRoomConnector registeredConnector in RegisteredConnectors)
			{
				NetworkIdentity netIdentity = registeredConnector.netIdentity;
				NetworkClient.prefabs[netIdentity.assetId] = netIdentity.gameObject;
			}
		}

		private void RegisterAll()
		{
			SpawnableRoomConnector[] spawnableConnectors = SpawnableConnectors;
			foreach (SpawnableRoomConnector element in spawnableConnectors)
			{
				RegisteredConnectors.AddIfNotContains(element);
			}
		}
	}
}
