using System.Collections.Generic;
using UnityEngine;

namespace OperationalGuide
{
	public class SpawnCandyPhysics : MonoBehaviour
	{
		public GameObject[] Candy;

		public Transform CandySpawnPosition;

		public static List<GameObject> SpawnedCandy = new List<GameObject>();

		private const int SpawnCount = 5;

		// Holding space showers random candies with physics.
		private void FixedUpdate()
		{
			if (Input.GetKey(KeyCode.Space))
			{
				for (int i = 0; i < 5; i++)
				{
					Vector3 position = new Vector3(Random.Range(-0.4f, 0.4f), Random.Range(-0.4f, 0.4f), Random.Range(-0.4f, 0.4f)) + CandySpawnPosition.position;
					GameObject item = Object.Instantiate(Candy[Random.Range(0, Candy.Length)], position, Quaternion.identity);
					SpawnedCandy.Add(item);
				}
			}
		}

		private void OnDisable()
		{
			foreach (GameObject item in SpawnedCandy)
			{
				Object.Destroy(item);
			}
			SpawnedCandy.Clear();
		}
	}
}
