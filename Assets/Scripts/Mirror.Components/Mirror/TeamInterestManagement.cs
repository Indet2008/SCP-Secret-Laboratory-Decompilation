namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Team/Team Interest Management")]
	public class TeamInterestManagement : global::Mirror.InterestManagement
	{
		private readonly global::System.Collections.Generic.Dictionary<string, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>> teamObjects = new global::System.Collections.Generic.Dictionary<string, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>>();

		private readonly global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, string> lastObjectTeam = new global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, string>();

		private readonly global::System.Collections.Generic.HashSet<string> dirtyTeams = new global::System.Collections.Generic.HashSet<string>();

		[global::Mirror.ServerCallback]
		public override void OnSpawned(global::Mirror.NetworkIdentity identity)
		{
			if (!global::Mirror.NetworkServer.active || !identity.TryGetComponent<global::Mirror.NetworkTeam>(out var component))
			{
				return;
			}
			string teamId = component.teamId;
			lastObjectTeam[identity] = teamId;
			if (!string.IsNullOrWhiteSpace(teamId))
			{
				if (!teamObjects.TryGetValue(teamId, out var value))
				{
					value = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>();
					teamObjects.Add(teamId, value);
				}
				value.Add(identity);
				dirtyTeams.Add(teamId);
			}
		}

		[global::Mirror.ServerCallback]
		public override void OnDestroyed(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active && lastObjectTeam.TryGetValue(identity, out var value))
			{
				lastObjectTeam.Remove(identity);
				if (!string.IsNullOrWhiteSpace(value) && teamObjects.TryGetValue(value, out var value2) && value2.Remove(identity))
				{
					dirtyTeams.Add(value);
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
				if (value2.TryGetComponent<global::Mirror.NetworkTeam>(out var component))
				{
					string teamId = component.teamId;
					if (lastObjectTeam.TryGetValue(value2, out var value) && !string.IsNullOrWhiteSpace(teamId) && !(teamId == value))
					{
						UpdateDirtyTeams(teamId, value);
						UpdateTeamObjects(value2, teamId, value);
					}
				}
			}
			foreach (string dirtyTeam in dirtyTeams)
			{
				RebuildTeamObservers(dirtyTeam);
			}
			dirtyTeams.Clear();
		}

		private void UpdateDirtyTeams(string newTeam, string currentTeam)
		{
			if (!string.IsNullOrWhiteSpace(currentTeam))
			{
				dirtyTeams.Add(currentTeam);
			}
			dirtyTeams.Add(newTeam);
		}

		private void UpdateTeamObjects(global::Mirror.NetworkIdentity netIdentity, string newTeam, string currentTeam)
		{
			if (!string.IsNullOrWhiteSpace(currentTeam))
			{
				teamObjects[currentTeam].Remove(netIdentity);
			}
			lastObjectTeam[netIdentity] = newTeam;
			if (!teamObjects.ContainsKey(newTeam))
			{
				teamObjects.Add(newTeam, new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>());
			}
			teamObjects[newTeam].Add(netIdentity);
		}

		private void RebuildTeamObservers(string teamId)
		{
			foreach (global::Mirror.NetworkIdentity item in teamObjects[teamId])
			{
				if (item != null)
				{
					global::Mirror.NetworkServer.RebuildObservers(item, initialize: false);
				}
			}
		}

		public override bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver)
		{
			if (!identity.TryGetComponent<global::Mirror.NetworkTeam>(out var component))
			{
				return true;
			}
			if (component.forceShown)
			{
				return true;
			}
			if (string.IsNullOrWhiteSpace(component.teamId))
			{
				return false;
			}
			if (!newObserver.identity.TryGetComponent<global::Mirror.NetworkTeam>(out var component2))
			{
				return true;
			}
			if (string.IsNullOrWhiteSpace(component2.teamId))
			{
				return false;
			}
			return component.teamId == component2.teamId;
		}

		public override void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			if (!identity.TryGetComponent<global::Mirror.NetworkTeam>(out var component))
			{
				AddAllConnections(newObservers);
			}
			else if (component.forceShown)
			{
				AddAllConnections(newObservers);
			}
			else
			{
				if (string.IsNullOrWhiteSpace(component.teamId) || !teamObjects.TryGetValue(component.teamId, out var value))
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

		private void AddAllConnections(global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			foreach (global::Mirror.NetworkConnectionToClient value in global::Mirror.NetworkServer.connections.Values)
			{
				if (value != null && value.isAuthenticated && value.identity != null)
				{
					newObservers.Add(value);
				}
			}
		}
	}
}
