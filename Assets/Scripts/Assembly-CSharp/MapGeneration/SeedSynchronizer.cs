using System;
using System.Diagnostics;
using GameCore;
using GameObjectPools;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration.RoomConnectors.Spawners;
using Mirror;
using UnityEngine;

namespace MapGeneration
{
	[DefaultExecutionOrder(1)]
	public class SeedSynchronizer : MonoBehaviour
	{
		public struct SeedMessage : NetworkMessage
		{
			public int Value;
		}

		public const int GenerationDisabledSeed = -1;

		private const string SeedConfigKey = "map_seed";

		private const string DebugLogChannel = "MAPGEN";

		private const string WarningLogFormat = "<color=orange>Warning:</color> {0}";

		private const string ErrorLogFormat = "<color=red>Fatal Error:</color> {0}";

		public static bool MapGenerated;

		[SerializeField]
		private ZoneGenerator[] _zoneGenerators;

		private static readonly Stopwatch MapgenSw = new Stopwatch();

		private static bool _seedTokenValid;

		private static SeedSynchronizer _singleton;

		public static float TimeSinceMapGeneration => (float)MapgenSw.Elapsed.TotalSeconds;

		public static int Seed { get; private set; }

		public static event Action OnBeforeGenerated;

		public static event Action<MapGenerationPhase> OnGenerationStage;

		public static event Action OnGenerationFinished;

		private void Awake()
		{
			_singleton = this;
			NetworkServer.OnConnectedEvent = (Action<NetworkConnectionToClient>)Delegate.Combine(NetworkServer.OnConnectedEvent, new Action<NetworkConnectionToClient>(OnNewPlayerConnected));
			if (!NetworkServer.active)
			{
				if (_seedTokenValid && !MapGenerated)
				{
					GenerateLevel(_seedTokenValid);
				}
				return;
			}
			int num = ConfigFile.ServerConfig.GetInt("map_seed", -1);
			if (num < 1)
			{
				Seed = UnityEngine.Random.Range(1, int.MaxValue);
				DebugInfo("Server has successfully generated a random seed: " + Seed, MessageImportance.Normal);
			}
			else
			{
				Seed = Mathf.Clamp(num, 1, int.MaxValue);
				DebugInfo("Server has successfully loaded a seed from config: " + Seed, MessageImportance.Normal);
			}
			MapGeneratingEventArgs e = new MapGeneratingEventArgs(Seed);
			ServerEvents.OnMapGenerating(e);
			if (!e.IsAllowed || e.Seed == -1)
			{
				DebugInfo("Map generation cancelled by a plugin.", MessageImportance.Normal);
				Seed = -1;
			}
			else
			{
				Seed = e.Seed;
			}
			NetworkServer.SendToAll(new SeedMessage
			{
				Value = Seed
			});
			GenerateLevel(Seed != -1);
		}

		private void OnDestroy()
		{
			_seedTokenValid = false;
			MapGenerated = false;
			NetworkServer.OnConnectedEvent = (Action<NetworkConnectionToClient>)Delegate.Remove(NetworkServer.OnConnectedEvent, new Action<NetworkConnectionToClient>(OnNewPlayerConnected));
		}

		private void GenerateLevel(bool generateFacility)
		{
			if (generateFacility)
			{
				GenerateFacility();
			}
			RoomConnectorSpawnpointBase.SetupAllRoomConnectors();
			ServerEvents.OnMapGenerated(new MapGeneratedEventArgs(Seed));
			if (NetworkServer.active)
			{
				PoolManager.Singleton.RestartRound();
			}
			MapGenerationPhase[] values = EnumUtils<MapGenerationPhase>.Values;
			foreach (MapGenerationPhase obj in values)
			{
				OnGenerationStage?.Invoke(obj);
			}
			MapGenerated = true;
			MapgenSw.Restart();
			OnGenerationFinished?.Invoke();
		}

		private void GenerateFacility()
		{
			OnBeforeGenerated?.Invoke();
			System.Random rng = new System.Random(Seed);
			_seedTokenValid = false;
			for (int i = 0; i < _zoneGenerators.Length; i++)
			{
				try
				{
					_zoneGenerators[i].Generate(rng);
				}
				catch (Exception exception)
				{
					UnityEngine.Debug.LogError("Map generation failed at " + _zoneGenerators[i].TargetZone);
					UnityEngine.Debug.LogException(exception);
				}
			}
			DebugInfo("Sequence of procedural level generation completed.", MessageImportance.Normal);
		}

		private void OnNewPlayerConnected(NetworkConnectionToClient connectionToClient)
		{
			if (connectionToClient != NetworkClient.connection)
			{
				connectionToClient.Send(new SeedMessage
				{
					Value = Seed
				});
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += () =>
			{
				NetworkClient.ReplaceHandler<SeedMessage>(ClientReceiveSeed);
			};
		}

		private static void ClientReceiveSeed(SeedMessage msg)
		{
			if (!NetworkServer.active)
			{
				Seed = msg.Value;
				_seedTokenValid = Seed != -1;
				if (!MapGenerated && _singleton != null)
				{
					_singleton.GenerateLevel(_seedTokenValid);
				}
			}
		}

		internal static void DebugInfo(string txt, MessageImportance importance, bool nospace = false)
		{
			GameCore.Console.AddDebugLog("MAPGEN", txt, importance, nospace);
		}

		internal static void DebugError(bool isFatal, string txt)
		{
			DebugInfo(string.Format(isFatal ? "<color=red>Fatal Error:</color> {0}" : "<color=orange>Warning:</color> {0}", txt), MessageImportance.MostImportant);
			UnityEngine.Debug.LogError("Map generation error for seed " + Seed + ": " + txt);
		}
	}
}
