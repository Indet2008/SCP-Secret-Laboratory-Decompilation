using UnityEngine;
using UnityEngine.Serialization;

namespace MapGeneration.Holidays
{
	public class HolidaySpawnable : HolidayRegistrable
	{
		[Range(0f, 100f)]
		[FormerlySerializedAs("SpawnChance")]
		public float BaseSpawnChance = 100f;

		[Range(0f, 100f)]
		public float FailIncrementAmount;

		[Range(0f, 100f)]
		public float MaxSpawnChance = 100f;

		private float _currentSpawnChance;

		public float CurrentSpawnChance
		{
			get
			{
				if (_currentSpawnChance <= BaseSpawnChance)
				{
					_currentSpawnChance = BaseSpawnChance;
				}
				return Mathf.Min(_currentSpawnChance, MaxSpawnChance);
			}
			set
			{
				_currentSpawnChance = Mathf.Clamp(value, 0f, MaxSpawnChance);
			}
		}
	}
}
