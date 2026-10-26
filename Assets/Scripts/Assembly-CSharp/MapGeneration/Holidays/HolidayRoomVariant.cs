using System;
using UnityEngine;

namespace MapGeneration.Holidays
{
	[Serializable]
	public struct HolidayRoomVariant : IHolidayFetchableData<SpawnableRoom>
	{
		[field: SerializeField]
		public HolidayType Holiday { get; private set; }

		[field: SerializeField]
		public SpawnableRoom Result { get; private set; }
	}
}
