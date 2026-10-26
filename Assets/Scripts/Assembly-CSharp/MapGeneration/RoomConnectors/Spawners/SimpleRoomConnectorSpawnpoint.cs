using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration.RoomConnectors.Spawners
{
	public class SimpleRoomConnectorSpawnpoint : RoomConnectorSpawnpointBase
	{
		public List<SpawnableRoomConnectorType> RoomConnectorTypes;

		[SerializeField]
		private SpawnableRoomConnectorType _fallbackType;

		public override SpawnableRoomConnectorType FallbackType => _fallbackType;

		public override float GetSpawnChanceWeight(SpawnableRoomConnectorType type)
		{
			return RoomConnectorTypes.Contains(type) ? 1 : 0;
		}

		protected override void MergeWith(RoomConnectorSpawnpointBase retired)
		{
			for (int num = RoomConnectorTypes.Count - 1; num >= 0; num--)
			{
				if (!(retired.GetSpawnChanceWeight(RoomConnectorTypes[num]) > 0f))
				{
					RoomConnectorTypes.RemoveAt(num);
				}
			}
			if (RoomConnectorTypes.Count == 0)
			{
				RoomConnectorTypes.Add(_fallbackType);
			}
		}
	}
}
