namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/interest-management")]
	public abstract class InterestManagement : global::Mirror.InterestManagementBase
	{
		private readonly global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient>();

		public abstract void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers);

		[global::Mirror.ServerCallback]
		protected void RebuildAll()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				return;
			}
			foreach (global::Mirror.NetworkIdentity value in global::Mirror.NetworkServer.spawned.Values)
			{
				global::Mirror.NetworkServer.RebuildObservers(value, initialize: false);
			}
		}

		public override void Rebuild(global::Mirror.NetworkIdentity identity, bool initialize)
		{
			newObservers.Clear();
			if (identity.visible != global::Mirror.Visibility.ForceHidden)
			{
				OnRebuildObservers(identity, newObservers);
			}
			if (identity.connectionToClient != null)
			{
				newObservers.Add(identity.connectionToClient);
			}
			bool flag = false;
			foreach (global::Mirror.NetworkConnectionToClient newObserver in newObservers)
			{
				if (newObserver != null && newObserver.isReady && (initialize || !identity.observers.ContainsKey(newObserver.connectionId)))
				{
					newObserver.AddToObserving(identity);
					flag = true;
				}
			}
			foreach (global::Mirror.NetworkConnectionToClient value in identity.observers.Values)
			{
				if (!newObservers.Contains(value))
				{
					value.RemoveFromObserving(identity, isDestroyed: false);
					flag = true;
				}
			}
			if (flag)
			{
				identity.observers.Clear();
				foreach (global::Mirror.NetworkConnectionToClient newObserver2 in newObservers)
				{
					if (newObserver2 != null && newObserver2.isReady)
					{
						identity.observers.Add(newObserver2.connectionId, newObserver2);
					}
				}
			}
			if (initialize && !newObservers.Contains(global::Mirror.NetworkServer.localConnection))
			{
				SetHostVisibility(identity, visible: false);
			}
		}
	}
}
