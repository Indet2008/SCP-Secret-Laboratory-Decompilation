using Hazards;
using Mirror;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class HazardsDistributor : SpawnablesDistributorBase
	{
		protected override void PlaceSpawnables()
		{
			foreach (HazardSpawnpointBase instance in HazardSpawnpointBase.Instances)
			{
				if (!(instance.MaximumSpawnChance <= (float)Random.Range(0, 100)))
				{
					instance.transform.GetPositionAndRotation(out var position, out var rotation);
					SpawnHazard(instance.HazardPrefab, position, rotation, instance.SpawnScale);
				}
			}
		}

		public static EnvironmentalHazard SpawnHazard(EnvironmentalHazard prefab, Vector3 position, Quaternion rotation, Vector3 scale)
		{
			EnvironmentalHazard environmentalHazard = Object.Instantiate(prefab);
			environmentalHazard.transform.SetPositionAndRotation(position, rotation);
			environmentalHazard.transform.localScale = scale;
			NetworkServer.Spawn(environmentalHazard.gameObject);
			return environmentalHazard;
		}
	}
}
