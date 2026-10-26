using System;
using Mirror;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public class HolidaySpawner : MonoBehaviour
	{
		private const int ChanceOverrideSeed = 53845;

		public HolidayRegistrable[] Spawnables;

		private System.Random _random;

		private void Start()
		{
			_random = new System.Random(SeedSynchronizer.Seed);
			HolidayRegistrable[] spawnables = Spawnables;
			foreach (HolidayRegistrable holidayRegistrable in spawnables)
			{
				if (holidayRegistrable.AvailableHolidays.IsAnyHolidayActive(mustBeForced: true))
				{
					if (holidayRegistrable is IHolidayCustomRegister holidayCustomRegister)
					{
						holidayCustomRegister.Register();
					}
					else
					{
						NetworkClient.RegisterPrefab(holidayRegistrable.gameObject);
					}
					if (NetworkServer.active && holidayRegistrable is HolidaySpawnable spawnable)
					{
						ServerSpawnInstance(spawnable);
					}
				}
			}
		}

		private void ServerSpawnInstance(HolidaySpawnable spawnable)
		{
			bool flag = SeedSynchronizer.Seed == 53845;
			if (_random.NextDouble() * 100.0 >= (double)spawnable.CurrentSpawnChance && !flag)
			{
				spawnable.CurrentSpawnChance += spawnable.FailIncrementAmount;
				return;
			}
			spawnable.CurrentSpawnChance = spawnable.BaseSpawnChance;
			if (spawnable is IHolidayCustomSpawner holidayCustomSpawner)
			{
				holidayCustomSpawner.Spawn();
			}
			else
			{
				NetworkServer.Spawn(UnityEngine.Object.Instantiate(spawnable.gameObject));
			}
		}
	}
}
