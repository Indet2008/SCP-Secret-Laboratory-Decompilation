using System;
using UnityEngine;

namespace MapGeneration.RoomConnectors
{
	[Serializable]
	public struct RoomConnectorSpawnData
	{
		public SpawnableRoomConnectorType ConnectorType;

		public int MinInstances;

		public int MaxInstances;

		[Range(0f, 1f)]
		public float MinPercent;

		[Range(0f, 1f)]
		public float MaxPercent;

		public readonly int GetRequired(int totalSpawnpoints)
		{
			return Mathf.Max(MinInstances, Mathf.RoundToInt((float)totalSpawnpoints * MinPercent));
		}

		public readonly int GetOptional(int totalSpawnpoints)
		{
			int num = Mathf.Min(MaxInstances, Mathf.RoundToInt((float)totalSpawnpoints * MaxPercent));
			return Mathf.Max(0, num - GetRequired(totalSpawnpoints));
		}
	}
}
