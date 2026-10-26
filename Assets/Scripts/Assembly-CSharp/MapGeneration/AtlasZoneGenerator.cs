using System;
using System.Collections.Generic;
using MapGeneration.Holidays;
using UnityEngine;

namespace MapGeneration
{
	public class AtlasZoneGenerator : ZoneGenerator
	{
		public struct SpawnedRoomData
		{
			public AtlasInterpretation Interpretation;

			public SpawnableRoom ChosenCandidate;

			public SpawnableRoom Instance;
		}

		private readonly List<SpawnableRoom> _spawnCandidates = new List<SpawnableRoom>();

		[SerializeField]
		private float _zoneHeight;

		public SpawnableRoom[] CompatibleRooms;

		public Texture2D[] Atlases;

		public Transform RoomSpawnParent;

		public readonly List<SpawnedRoomData> Spawned = new List<SpawnedRoomData>();

		public AtlasInterpretation[] Interpreted { get; private set; }

		public override void Generate(System.Random rng)
		{
			SpawnableRoom[] compatibleRooms = CompatibleRooms;
			foreach (SpawnableRoom spawnableRoom in compatibleRooms)
			{
				try
				{
					if (spawnableRoom.HolidayVariants.TryGetResult<HolidayRoomVariant, SpawnableRoom>(out var result) && result != null)
					{
						result.RegisterIdentities();
					}
					else
					{
						spawnableRoom.RegisterIdentities();
					}
				}
				catch (Exception arg)
				{
					Debug.LogError($"Failed to register identities for room {spawnableRoom.name} in zone {TargetZone}:\n{arg}");
				}
			}
			Texture2D atlas = Atlases[rng.Next(Atlases.Length)];
			Interpreted = MapAtlasInterpreter.Singleton.Interpret(atlas, rng);
			RandomizeInterpreted(rng);
			for (int j = 0; j < Interpreted.Length; j++)
			{
				try
				{
					ProcessInterpreted(Interpreted[j], rng);
				}
				catch (Exception exception)
				{
					AtlasInterpretation atlasInterpretation = Interpreted[j];
					Debug.LogError("Interpretation failed at " + atlasInterpretation.ToString());
					Debug.LogException(exception);
				}
			}
		}

		protected virtual void RandomizeInterpreted(System.Random rng)
		{
			int num = Interpreted.Length;
			while (num > 1)
			{
				num--;
				int num2 = rng.Next(num + 1);
				ref AtlasInterpretation reference = ref Interpreted[num];
				ref AtlasInterpretation reference2 = ref Interpreted[num2];
				AtlasInterpretation atlasInterpretation = Interpreted[num2];
				AtlasInterpretation atlasInterpretation2 = Interpreted[num];
				reference = atlasInterpretation;
				reference2 = atlasInterpretation2;
			}
		}

		public virtual void GetPositionAndRotation(AtlasInterpretation toSpawn, out Vector3 worldPosition, out float yRotation)
		{
			worldPosition = new Vector3((float)toSpawn.Coords.x * RoomIdentifier.GridScale.x, _zoneHeight, (float)toSpawn.Coords.y * RoomIdentifier.GridScale.z);
			yRotation = toSpawn.RotationY;
		}

		public virtual float GetChanceWeight(Vector2Int coords, SpawnableRoom candidate)
		{
			Vector2Int vector2Int = coords + Vector2Int.up;
			Vector2Int vector2Int2 = coords + Vector2Int.down;
			Vector2Int vector2Int3 = coords + Vector2Int.left;
			Vector2Int vector2Int4 = coords + Vector2Int.right;
			float num = candidate.ChanceMultiplier;
			foreach (SpawnedRoomData item in Spawned)
			{
				if (!(item.ChosenCandidate != candidate))
				{
					Vector2Int coords2 = item.Interpretation.Coords;
					if (coords2 == vector2Int || coords2 == vector2Int2 || coords2 == vector2Int3 || coords2 == vector2Int4)
					{
						num *= candidate.AdjacentChanceMultiplier;
					}
				}
			}
			return num;
		}

		public int PreviouslySpawnedCnt(SpawnableRoom candidate)
		{
			int num = 0;
			foreach (SpawnedRoomData item in Spawned)
			{
				if (!(item.ChosenCandidate != candidate))
				{
					num++;
				}
			}
			return num;
		}

		public void SpawnRoom(AtlasInterpretation interpretation, SpawnableRoom chosenCandidate)
		{
			GetPositionAndRotation(interpretation, out var worldPosition, out var yRotation);
			SpawnableRoom spawnableRoom = UnityEngine.Object.Instantiate(chosenCandidate, worldPosition, Quaternion.Euler(0f, yRotation, 0f), RoomSpawnParent);
			spawnableRoom.SetupNetIdHandlers(PreviouslySpawnedCnt(chosenCandidate));
			Spawned.Add(new SpawnedRoomData
			{
				ChosenCandidate = chosenCandidate,
				Instance = spawnableRoom,
				Interpretation = interpretation
			});
		}

		private void ProcessInterpreted(AtlasInterpretation interpretation, System.Random rng)
		{
			_spawnCandidates.Clear();
			float num = 0f;
			bool flag = interpretation.SpecificRooms.Length != 0;
			for (int i = 0; i < CompatibleRooms.Length; i++)
			{
				SpawnableRoom spawnableRoom = CompatibleRooms[i];
				if (spawnableRoom.HolidayVariants.TryGetResult<HolidayRoomVariant, SpawnableRoom>(out var result))
				{
					if (result == null)
					{
						Debug.LogError("[AtlasZoneGenerator] " + spawnableRoom.name + " had a null variant defined.");
					}
					else
					{
						spawnableRoom = result;
					}
				}
				int num2 = PreviouslySpawnedCnt(spawnableRoom);
				if (flag == spawnableRoom.SpecialRoom && (!flag || interpretation.SpecificRooms.Contains(spawnableRoom.Room.Name)) && spawnableRoom.Room.Shape == interpretation.RoomShape && num2 < spawnableRoom.MaxAmount)
				{
					if (num2 < spawnableRoom.MinAmount)
					{
						SpawnRoom(interpretation, spawnableRoom);
						return;
					}
					num += GetChanceWeight(interpretation.Coords, spawnableRoom);
					_spawnCandidates.Add(spawnableRoom);
				}
			}
			if (_spawnCandidates.Count == 0 || num == 0f)
			{
				Debug.LogError($"No candidates found for {TargetZone} {interpretation}");
				return;
			}
			double num3 = rng.NextDouble() * (double)num;
			float num4 = 0f;
			for (int j = 0; j < _spawnCandidates.Count; j++)
			{
				SpawnableRoom spawnableRoom2 = _spawnCandidates[j];
				num4 += GetChanceWeight(interpretation.Coords, spawnableRoom2);
				if (num3 <= (double)num4)
				{
					SpawnRoom(interpretation, spawnableRoom2);
					return;
				}
			}
			Debug.LogError($"Random room spawning failed for {TargetZone} {interpretation}");
		}
	}
}
