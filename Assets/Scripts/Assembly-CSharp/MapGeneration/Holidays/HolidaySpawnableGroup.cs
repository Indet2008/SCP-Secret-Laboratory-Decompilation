using Mirror;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public class HolidaySpawnableGroup : HolidaySpawnable, IHolidayCustomRegister, IHolidayCustomSpawner
	{
		[field: SerializeField]
		public HolidaySpawnable[] SubSpawnables { get; private set; }

		public void Register()
		{
			HolidaySpawnable[] subSpawnables = SubSpawnables;
			for (int i = 0; i < subSpawnables.Length; i++)
			{
				NetworkClient.RegisterPrefab(subSpawnables[i].gameObject);
			}
		}

		public void Spawn()
		{
			HolidaySpawnable[] subSpawnables = SubSpawnables;
			for (int i = 0; i < subSpawnables.Length; i++)
			{
				NetworkServer.Spawn(Object.Instantiate(subSpawnables[i].gameObject));
			}
		}
	}
}
