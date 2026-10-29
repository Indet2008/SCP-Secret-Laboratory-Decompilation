using UnityEngine;

namespace OperationalGuide
{
	public class CandyDespawner : MonoBehaviour
	{
		private const float HeightDespawnThreshold = -5f;

		private void FixedUpdate()
		{
			if (!(base.transform.localPosition.y >= -5f))
			{
				SpawnCandyPhysics.SpawnedCandy.Remove(base.gameObject);
				Object.Destroy(base.gameObject);
			}
		}
	}
}
