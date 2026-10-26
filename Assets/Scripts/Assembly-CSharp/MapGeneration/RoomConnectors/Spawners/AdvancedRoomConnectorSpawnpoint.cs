using System;
using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration.RoomConnectors.Spawners
{
	public class AdvancedRoomConnectorSpawnpoint : RoomConnectorSpawnpointBase
	{
		[Serializable]
		public struct ConnectorTypesChancePair
		{
			public float Chance;

			public List<SpawnableRoomConnectorType> RoomConnectorTypes;
		}

		public ConnectorTypesChancePair[] Connectors;

		[SerializeField]
		private SpawnableRoomConnectorType _fallbackType;

		public override SpawnableRoomConnectorType FallbackType => _fallbackType;

		public override float GetSpawnChanceWeight(SpawnableRoomConnectorType type)
		{
			bool flag = false;
			ConnectorTypesChancePair[] connectors = Connectors;
			for (int i = 0; i < connectors.Length; i++)
			{
				ConnectorTypesChancePair connectorTypesChancePair = connectors[i];
				if (!(connectorTypesChancePair.Chance <= 0f) && connectorTypesChancePair.RoomConnectorTypes.Count != 0)
				{
					flag = true;
					if (connectorTypesChancePair.RoomConnectorTypes.Contains(type))
					{
						return connectorTypesChancePair.Chance;
					}
				}
			}
			if (flag)
			{
				return 0f;
			}
			return (type != _fallbackType) ? 1 : 0;
		}

		public override void SpawnFallback()
		{
			List<SpawnableRoomConnectorType> list = new List<SpawnableRoomConnectorType>();
			ConnectorTypesChancePair[] connectors = Connectors;
			for (int i = 0; i < connectors.Length; i++)
			{
				ConnectorTypesChancePair connectorTypesChancePair = connectors[i];
				list.AddRange(connectorTypesChancePair.RoomConnectorTypes);
			}
			if (list.Count > 0)
			{
				Spawn(list.RandomItem());
			}
			else
			{
				base.SpawnFallback();
			}
		}

		protected override void MergeWith(RoomConnectorSpawnpointBase retired)
		{
			ConnectorTypesChancePair[] connectors = Connectors;
			for (int i = 0; i < connectors.Length; i++)
			{
				ConnectorTypesChancePair connectorTypesChancePair = connectors[i];
				for (int num = connectorTypesChancePair.RoomConnectorTypes.Count - 1; num >= 0; num--)
				{
					if (!(retired.GetSpawnChanceWeight(connectorTypesChancePair.RoomConnectorTypes[num]) > 0f))
					{
						connectorTypesChancePair.RoomConnectorTypes.RemoveAt(num);
					}
				}
			}
		}
	}
}
