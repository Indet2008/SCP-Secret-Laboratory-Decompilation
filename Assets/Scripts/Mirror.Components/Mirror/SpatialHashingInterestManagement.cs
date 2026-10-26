namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Spatial Hash/Spatial Hashing Interest Management")]
	public class SpatialHashingInterestManagement : global::Mirror.InterestManagement
	{
		public enum CheckMethod
		{
			XZ_FOR_3D = 0,
			XY_FOR_2D = 1
		}

		[global::UnityEngine.Tooltip("The maximum range that objects will be visible at.")]
		public int visRange = 30;

		[global::UnityEngine.Tooltip("Rebuild all every 'rebuildInterval' seconds.")]
		public float rebuildInterval = 1f;

		private double lastRebuildTime;

		[global::UnityEngine.Tooltip("Spatial Hashing supports 3D (XZ) and 2D (XY) games.")]
		public global::Mirror.SpatialHashingInterestManagement.CheckMethod checkMethod;

		public bool showSlider;

		private global::Mirror.Grid2D<global::Mirror.NetworkConnectionToClient> grid = new global::Mirror.Grid2D<global::Mirror.NetworkConnectionToClient>(1024);

		public int resolution => visRange / 2;

		private global::UnityEngine.Vector2Int ProjectToGrid(global::UnityEngine.Vector3 position)
		{
			if (checkMethod != global::Mirror.SpatialHashingInterestManagement.CheckMethod.XZ_FOR_3D)
			{
				return global::UnityEngine.Vector2Int.RoundToInt(new global::UnityEngine.Vector2(position.x, position.y) / resolution);
			}
			return global::UnityEngine.Vector2Int.RoundToInt(new global::UnityEngine.Vector2(position.x, position.z) / resolution);
		}

		public override bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver)
		{
			global::UnityEngine.Vector2Int vector2Int = ProjectToGrid(identity.transform.position);
			global::UnityEngine.Vector2Int vector2Int2 = ProjectToGrid(newObserver.identity.transform.position);
			return (vector2Int - vector2Int2).sqrMagnitude <= 2;
		}

		public override void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			global::UnityEngine.Vector2Int position = ProjectToGrid(identity.transform.position);
			grid.GetWithNeighbours(position, newObservers);
		}

		[global::Mirror.ServerCallback]
		public override void Reset()
		{
			if (global::Mirror.NetworkServer.active)
			{
				lastRebuildTime = 0.0;
			}
		}

		[global::Mirror.ServerCallback]
		internal void Update()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				return;
			}
			grid.ClearNonAlloc();
			foreach (global::Mirror.NetworkConnectionToClient value in global::Mirror.NetworkServer.connections.Values)
			{
				if (value.isAuthenticated && value.identity != null)
				{
					global::UnityEngine.Vector2Int position = ProjectToGrid(value.identity.transform.position);
					grid.Add(position, value);
				}
			}
			if (global::Mirror.NetworkTime.localTime >= lastRebuildTime + (double)rebuildInterval)
			{
				RebuildAll();
				lastRebuildTime = global::Mirror.NetworkTime.localTime;
			}
		}
	}
}
