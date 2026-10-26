namespace OperationalGuide
{
	public class SpawnCandyPhysics : global::UnityEngine.MonoBehaviour
	{
		public global::UnityEngine.GameObject[] Candy;

		public global::UnityEngine.Transform CandySpawnPosition;

		public static global::System.Collections.Generic.List<global::UnityEngine.GameObject> SpawnedCandy;

		private const int SpawnCount = 5;

		private void FixedUpdate()
		{
		}

		private void OnDisable()
		{
		}

		public SpawnCandyPhysics()
		{
		}
	}
}
