namespace Mirror
{
	public abstract class Transport : global::UnityEngine.MonoBehaviour
	{
		public static global::Mirror.Transport active;

		public global::System.Action OnClientConnected;

		public global::System.Action<global::System.ArraySegment<byte>, int> OnClientDataReceived;

		public global::System.Action<global::System.ArraySegment<byte>, int> OnClientDataSent;

		public global::System.Action<global::Mirror.TransportError, string> OnClientError;

		public global::System.Action OnClientDisconnected;

		public global::System.Action<int> OnServerConnected;

		public global::System.Action<int, global::System.ArraySegment<byte>, int> OnServerDataReceived;

		public global::System.Action<int, global::System.ArraySegment<byte>, int> OnServerDataSent;

		public global::System.Action<int, global::Mirror.TransportError, string> OnServerError;

		public global::System.Action<int> OnServerDisconnected;

		public abstract bool Available();

		public abstract bool ClientConnected();

		public abstract void ClientConnect(string address);

		public virtual void ClientConnect(global::System.Uri uri)
		{
			ClientConnect(uri.Host);
		}

		public abstract void ClientSend(global::System.ArraySegment<byte> segment, int channelId = 0);

		public abstract void ClientDisconnect();

		public abstract global::System.Uri ServerUri();

		public abstract bool ServerActive();

		public abstract void ServerStart();

		public abstract void ServerSend(int connectionId, global::System.ArraySegment<byte> segment, int channelId = 0);

		public abstract void ServerDisconnect(int connectionId);

		public abstract string ServerGetClientAddress(int connectionId);

		public abstract void ServerStop();

		public abstract int GetMaxPacketSize(int channelId = 0);

		public virtual int GetBatchThreshold(int channelId = 0)
		{
			return GetMaxPacketSize(channelId);
		}

		public void Update()
		{
		}

		public void LateUpdate()
		{
		}

		public virtual void ClientEarlyUpdate()
		{
		}

		public virtual void ServerEarlyUpdate()
		{
		}

		public virtual void ClientLateUpdate()
		{
		}

		public virtual void ServerLateUpdate()
		{
		}

		public abstract void Shutdown();

		public virtual void OnApplicationQuit()
		{
			Shutdown();
		}
	}
}
