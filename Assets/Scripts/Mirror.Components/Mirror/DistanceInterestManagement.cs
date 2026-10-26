namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Distance/Distance Interest Management")]
	public class DistanceInterestManagement : global::Mirror.InterestManagement
	{
		[global::UnityEngine.Tooltip("The maximum range that objects will be visible at. Add DistanceInterestManagementCustomRange onto NetworkIdentities for custom ranges.")]
		public int visRange = 500;

		[global::UnityEngine.Tooltip("Rebuild all every 'rebuildInterval' seconds.")]
		public float rebuildInterval = 1f;

		private double lastRebuildTime;

		private readonly global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::Mirror.DistanceInterestManagementCustomRange> CustomRanges = new global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::Mirror.DistanceInterestManagementCustomRange>();

		[global::Mirror.ServerCallback]
		private int GetVisRange(global::Mirror.NetworkIdentity identity)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				return default;
			}
			if (!CustomRanges.TryGetValue(identity, out var value))
			{
				return visRange;
			}
			return value.visRange;
		}

		[global::Mirror.ServerCallback]
		public override void Reset()
		{
			if (global::Mirror.NetworkServer.active)
			{
				lastRebuildTime = 0.0;
				CustomRanges.Clear();
			}
		}

		public override void OnSpawned(global::Mirror.NetworkIdentity identity)
		{
			if (identity.TryGetComponent<global::Mirror.DistanceInterestManagementCustomRange>(out var component))
			{
				CustomRanges[identity] = component;
			}
		}

		public override void OnDestroyed(global::Mirror.NetworkIdentity identity)
		{
			CustomRanges.Remove(identity);
		}

		public override bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver)
		{
			int num = GetVisRange(identity);
			return global::UnityEngine.Vector3.Distance(identity.transform.position, newObserver.identity.transform.position) < (float)num;
		}

		public override void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			int num = GetVisRange(identity);
			global::UnityEngine.Vector3 position = identity.transform.position;
			foreach (global::Mirror.NetworkConnectionToClient value in global::Mirror.NetworkServer.connections.Values)
			{
				if (value != null && value.isAuthenticated && value.identity != null && global::UnityEngine.Vector3.Distance(value.identity.transform.position, position) < (float)num)
				{
					newObservers.Add(value);
				}
			}
		}

		[global::Mirror.ServerCallback]
		internal void Update()
		{
			if (global::Mirror.NetworkServer.active && global::Mirror.NetworkTime.localTime >= lastRebuildTime + (double)rebuildInterval)
			{
				RebuildAll();
				lastRebuildTime = global::Mirror.NetworkTime.localTime;
			}
		}
	}
}
