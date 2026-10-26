using CustomPlayerEffects;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using InventorySystem;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using Respawning;
using Respawning.Waves;
using RoundRestarting;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public static class Scp1507Spawner
	{
		public enum State
		{
			Idle = 0,
			WaitForRespawnCycle = 1,
			WaitForSpectators = 2,
			Spawning = 3,
			Spawned = 4
		}

		private static ReferenceHub _alpha;

		private static float _elapsed;

		private const int SpawnWaveSetTimeSeconds = 240;

		private const float MiniwaveTimerMultiplier = 0.5f;

		private const float SpawnAnimDelaySeconds = 5f;

		private const float MinSpectatorsPercent = 0.3f;

		private const float MinSpawnDelaySeconds = 7f;

		private const float MaxSpawnDelaySeconds = 180f;

		private static readonly Vector3 PostDetonationSpawnpoint = new Vector3(124f, 288.85f, 27f);

		public static State CurState { get; private set; }

		private static bool Inactive
		{
			get
			{
				if (CurState != State.Idle)
				{
					return CurState == State.Spawned;
				}
				return true;
			}
		}

		public static void StartSpawning(ReferenceHub newAlpha)
		{
			_alpha = newAlpha;
			if (Inactive)
			{
				_elapsed = 0f;
				StaticUnityMethods.OnUpdate += Update;
				ReferenceHub.OnPlayerRemoved += OnPlayerRemoved;
				CurState = State.WaitForRespawnCycle;
			}
		}

		public static void Restore()
		{
			if (!Inactive)
			{
				StaticUnityMethods.OnUpdate -= Update;
				ReferenceHub.OnPlayerRemoved -= OnPlayerRemoved;
			}
			CurState = State.Idle;
		}

		private static void Spawn()
		{
			Restore();
			CurState = State.Spawned;
			_alpha.inventory.ServerDropEverything();
			SpawnPlayer(_alpha, RoleTypeId.AlphaFlamingo);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (ValidatePlayer(allHub))
				{
					SpawnPlayer(allHub, RoleTypeId.Flamingo);
				}
			}
			if (ElevatorChamber.TryGetChamber(ElevatorGroup.Nuke01, out var chamber))
			{
				chamber.ServerSetDestination(1, allowQueueing: true);
				if (ElevatorChamber.TryGetChamber(ElevatorGroup.Nuke02, out var chamber2))
				{
					chamber2.ServerSetDestination(1, allowQueueing: true);
				}
			}
			static void SpawnPlayer(ReferenceHub hub, RoleTypeId role)
			{
				if (AlphaWarheadController.Detonated || DeadmanSwitch.IsSequenceActive)
				{
					hub.roleManager.ServerSetRole(role, RoleChangeReason.ItemUsage, ~RoleSpawnFlags.UseSpawnpoint);
					hub.TryOverridePosition(PostDetonationSpawnpoint);
					hub.TryOverrideRotation(Vector3.zero);
					HandleEscapeDoor();
				}
				else
				{
					hub.roleManager.ServerSetRole(role, RoleChangeReason.ItemUsage);
				}
			}
		}

		private static void HandleEscapeDoor()
		{
			if (DoorNametagExtension.NamedDoors.TryGetValue("ESCAPE_FINAL", out var value))
			{
				value.TargetDoor.NetworkTargetState = true;
			}
		}

		private static bool ValidatePlayer(ReferenceHub candidate)
		{
			if (candidate.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false })
			{
				return candidate != _alpha;
			}
			return false;
		}

		private static void OnPlayerRemoved(ReferenceHub hub)
		{
			if (!(hub != _alpha))
			{
				Restore();
			}
		}

		private static void Update()
		{
			_elapsed += Time.deltaTime;
			switch (CurState)
			{
			case State.WaitForRespawnCycle:
				UpdateWaitForRespawnCycle();
				break;
			case State.WaitForSpectators:
				UpdateWaitForSpectators();
				break;
			case State.Spawning:
				UpdateSpawning();
				break;
			}
		}

		private static void UpdateWaitForRespawnCycle()
		{
			if (WaveManager.State != WaveQueueState.Idle)
			{
				return;
			}
			CurState = State.WaitForSpectators;
			foreach (TimeBasedWave wave in WaveManager.Waves)
			{
				float num = 240f;
				if (wave is IMiniWave)
				{
					num *= 0.5f;
				}
				wave.Timer.SpawnIntervalSeconds = num;
				wave.Timer.Reset();
			}
		}

		private static void UpdateWaitForSpectators()
		{
			if (!(_elapsed < 7f))
			{
				float num = ReferenceHub.AllHubs.Count(ValidatePlayer);
				float num2 = ReferenceHub.AllHubs.Count - 2;
				if (!(((num2 <= 0f) ? 1f : (num / num2)) < 0.3f) || !(_elapsed < 180f))
				{
					_elapsed = 0f;
					CurState = State.Spawning;
					_alpha.playerEffectsController.EnableEffect<BecomingFlamingo>();
				}
			}
		}

		private static void UpdateSpawning()
		{
			if (!(_elapsed < 5f))
			{
				Spawn();
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			RoundRestart.OnRestartTriggered += Restore;
		}
	}
}
