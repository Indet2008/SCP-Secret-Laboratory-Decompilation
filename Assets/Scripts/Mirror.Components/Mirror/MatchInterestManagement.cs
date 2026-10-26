namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Match/Match Interest Management")]
	public class MatchInterestManagement : global::Mirror.InterestManagement
	{
		private readonly global::System.Collections.Generic.Dictionary<global::System.Guid, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>> matchObjects = new global::System.Collections.Generic.Dictionary<global::System.Guid, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>>();

		private readonly global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::System.Guid> lastObjectMatch = new global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::System.Guid>();

		private readonly global::System.Collections.Generic.HashSet<global::System.Guid> dirtyMatches = new global::System.Collections.Generic.HashSet<global::System.Guid>();

		[global::Mirror.ServerCallback]
		public override void OnSpawned(global::Mirror.NetworkIdentity identity)
		{
			if (!global::Mirror.NetworkServer.active || !identity.TryGetComponent<global::Mirror.NetworkMatch>(out var component))
			{
				return;
			}
			global::System.Guid matchId = component.matchId;
			lastObjectMatch[identity] = matchId;
			if (!(matchId == global::System.Guid.Empty))
			{
				if (!matchObjects.TryGetValue(matchId, out var value))
				{
					value = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>();
					matchObjects.Add(matchId, value);
				}
				value.Add(identity);
				dirtyMatches.Add(matchId);
			}
		}

		[global::Mirror.ServerCallback]
		public override void OnDestroyed(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active && lastObjectMatch.TryGetValue(identity, out var value))
			{
				lastObjectMatch.Remove(identity);
				if (value != global::System.Guid.Empty && matchObjects.TryGetValue(value, out var value2) && value2.Remove(identity))
				{
					dirtyMatches.Add(value);
				}
			}
		}

		[global::Mirror.ServerCallback]
		internal void Update()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				return;
			}
			foreach (global::Mirror.NetworkIdentity value2 in global::Mirror.NetworkServer.spawned.Values)
			{
				if (value2.TryGetComponent<global::Mirror.NetworkMatch>(out var component))
				{
					global::System.Guid matchId = component.matchId;
					if (lastObjectMatch.TryGetValue(value2, out var value) && !(matchId == global::System.Guid.Empty) && !(matchId == value))
					{
						UpdateDirtyMatches(matchId, value);
						UpdateMatchObjects(value2, matchId, value);
					}
				}
			}
			foreach (global::System.Guid dirtyMatch in dirtyMatches)
			{
				RebuildMatchObservers(dirtyMatch);
			}
			dirtyMatches.Clear();
		}

		private void UpdateDirtyMatches(global::System.Guid newMatch, global::System.Guid currentMatch)
		{
			if (currentMatch != global::System.Guid.Empty)
			{
				dirtyMatches.Add(currentMatch);
			}
			dirtyMatches.Add(newMatch);
		}

		private void UpdateMatchObjects(global::Mirror.NetworkIdentity netIdentity, global::System.Guid newMatch, global::System.Guid currentMatch)
		{
			if (currentMatch != global::System.Guid.Empty)
			{
				matchObjects[currentMatch].Remove(netIdentity);
			}
			lastObjectMatch[netIdentity] = newMatch;
			if (!matchObjects.ContainsKey(newMatch))
			{
				matchObjects.Add(newMatch, new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>());
			}
			matchObjects[newMatch].Add(netIdentity);
		}

		private void RebuildMatchObservers(global::System.Guid matchId)
		{
			foreach (global::Mirror.NetworkIdentity item in matchObjects[matchId])
			{
				if (item != null)
				{
					global::Mirror.NetworkServer.RebuildObservers(item, initialize: false);
				}
			}
		}

		public override bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver)
		{
			if (!identity.TryGetComponent<global::Mirror.NetworkMatch>(out var component))
			{
				return false;
			}
			if (component.matchId == global::System.Guid.Empty)
			{
				return false;
			}
			if (!newObserver.identity.TryGetComponent<global::Mirror.NetworkMatch>(out var component2))
			{
				return false;
			}
			if (component2.matchId == global::System.Guid.Empty)
			{
				return false;
			}
			return component.matchId == component2.matchId;
		}

		public override void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			if (!identity.TryGetComponent<global::Mirror.NetworkMatch>(out var component))
			{
				return;
			}
			global::System.Guid matchId = component.matchId;
			if (matchId == global::System.Guid.Empty || !matchObjects.TryGetValue(matchId, out var value))
			{
				return;
			}
			foreach (global::Mirror.NetworkIdentity item in value)
			{
				if (item != null && item.connectionToClient != null)
				{
					newObservers.Add(item.connectionToClient);
				}
			}
		}
	}
}
