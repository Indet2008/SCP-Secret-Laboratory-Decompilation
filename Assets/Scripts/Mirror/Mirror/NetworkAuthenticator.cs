namespace Mirror
{
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-authenticators")]
	public abstract class NetworkAuthenticator : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.Header("Event Listeners (optional)")]
		[global::UnityEngine.Tooltip("Mirror has an internal subscriber to this event. You can add your own here.")]
		public global::Mirror.UnityEventNetworkConnection OnServerAuthenticated = new global::Mirror.UnityEventNetworkConnection();

		[global::UnityEngine.Tooltip("Mirror has an internal subscriber to this event. You can add your own here.")]
		public global::UnityEngine.Events.UnityEvent OnClientAuthenticated = new global::UnityEngine.Events.UnityEvent();

		public virtual void OnStartServer()
		{
		}

		public virtual void OnStopServer()
		{
		}

		public virtual void OnServerAuthenticate(global::Mirror.NetworkConnectionToClient conn)
		{
		}

		protected void ServerAccept(global::Mirror.NetworkConnectionToClient conn)
		{
			OnServerAuthenticated.Invoke(conn);
		}

		protected void ServerReject(global::Mirror.NetworkConnectionToClient conn)
		{
			conn.Disconnect();
		}

		public virtual void OnStartClient()
		{
		}

		public virtual void OnStopClient()
		{
		}

		public virtual void OnClientAuthenticate()
		{
		}

		protected void ClientAccept()
		{
			OnClientAuthenticated.Invoke();
		}

		protected void ClientReject()
		{
			global::Mirror.NetworkClient.connection.isAuthenticated = false;
			global::Mirror.NetworkClient.connection.Disconnect();
		}

		private void Reset()
		{
		}
	}
}
