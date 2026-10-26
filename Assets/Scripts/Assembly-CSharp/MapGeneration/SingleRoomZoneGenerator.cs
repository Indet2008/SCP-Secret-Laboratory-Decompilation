using System;
using MapGeneration.Holidays;
using UnityEngine;

namespace MapGeneration
{
	public class SingleRoomZoneGenerator : ZoneGenerator
	{
		[SerializeField]
		private Pose _spawnPosition;

		public Transform ZoneSpawnParent;

		public SpawnableRoom Prefab;

		public override void Generate(System.Random rng)
		{
			if (!Prefab.HolidayVariants.TryGetResult<HolidayRoomVariant, SpawnableRoom>(out var result))
			{
				result = Prefab;
			}
			result.RegisterIdentities();
			UnityEngine.Object.Instantiate(result, _spawnPosition.position, _spawnPosition.rotation, ZoneSpawnParent).SetupNetIdHandlers(0);
		}
	}
}
