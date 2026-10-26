namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/interest-management")]
	public abstract class InterestManagementBase : global::UnityEngine.MonoBehaviour
	{
		protected virtual void OnEnable()
		{
			if (global::Mirror.NetworkServer.aoi == null)
			{
				global::Mirror.NetworkServer.aoi = this;
			}
			else
			{
				global::UnityEngine.Debug.LogError($"Only one InterestManagement component allowed. {(global::Mirror.NetworkServer.aoi.GetType())} has been set up already.");
			}
			if (global::Mirror.NetworkClient.aoi == null)
			{
				global::Mirror.NetworkClient.aoi = this;
			}
			else
			{
				global::UnityEngine.Debug.LogError($"Only one InterestManagement component allowed. {(global::Mirror.NetworkClient.aoi.GetType())} has been set up already.");
			}
		}

		[global::Mirror.ServerCallback]
		public virtual void Reset()
		{
			if (global::Mirror.NetworkServer.active)
			{
			}
		}

		public abstract bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver);

		[global::Mirror.ServerCallback]
		public virtual void SetHostVisibility(global::Mirror.NetworkIdentity identity, bool visible)
		{
			if (global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Renderer[] componentsInChildren = identity.GetComponentsInChildren<global::UnityEngine.Renderer>();
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					componentsInChildren[i].enabled = visible;
				}
			}
		}

		[global::Mirror.ServerCallback]
		public virtual void OnSpawned(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active)
			{
			}
		}

		[global::Mirror.ServerCallback]
		public virtual void OnDestroyed(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active)
			{
			}
		}

		public abstract void Rebuild(global::Mirror.NetworkIdentity identity, bool initialize);

		protected void AddObserver(global::Mirror.NetworkConnectionToClient connection, global::Mirror.NetworkIdentity identity)
		{
			connection.AddToObserving(identity);
			identity.observers.Add(connection.connectionId, connection);
		}

		protected void RemoveObserver(global::Mirror.NetworkConnectionToClient connection, global::Mirror.NetworkIdentity identity)
		{
			connection.RemoveFromObserving(identity, isDestroyed: false);
			identity.observers.Remove(connection.connectionId);
		}
	}
}
