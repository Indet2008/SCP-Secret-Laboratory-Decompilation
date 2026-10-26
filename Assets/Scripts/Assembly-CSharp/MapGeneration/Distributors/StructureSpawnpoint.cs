using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration.Distributors
{
	[DefaultExecutionOrder(-1)]
	public class StructureSpawnpoint : DistributorSpawnpointBase
	{
		public static readonly HashSet<StructureSpawnpoint> AvailableInstances = new HashSet<StructureSpawnpoint>();

		public StructureType[] CompatibleStructures;

		public string TriggerDoorName;

		private new void Awake()
		{
			AvailableInstances.Add(this);
		}

		private void OnDestroy()
		{
			AvailableInstances.Remove(this);
		}
	}
}
