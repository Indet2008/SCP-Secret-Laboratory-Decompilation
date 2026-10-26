namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/Network Statistics")]
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-statistics")]
	public class NetworkStatistics : global::UnityEngine.MonoBehaviour
	{
		private double intervalStartTime;

		[global::UnityEngine.HideInInspector]
		public int clientIntervalReceivedPackets;

		[global::UnityEngine.HideInInspector]
		public long clientIntervalReceivedBytes;

		[global::UnityEngine.HideInInspector]
		public int clientIntervalSentPackets;

		[global::UnityEngine.HideInInspector]
		public long clientIntervalSentBytes;

		[global::UnityEngine.HideInInspector]
		public int clientReceivedPacketsPerSecond;

		[global::UnityEngine.HideInInspector]
		public long clientReceivedBytesPerSecond;

		[global::UnityEngine.HideInInspector]
		public int clientSentPacketsPerSecond;

		[global::UnityEngine.HideInInspector]
		public long clientSentBytesPerSecond;

		[global::UnityEngine.HideInInspector]
		public int serverIntervalReceivedPackets;

		[global::UnityEngine.HideInInspector]
		public long serverIntervalReceivedBytes;

		[global::UnityEngine.HideInInspector]
		public int serverIntervalSentPackets;

		[global::UnityEngine.HideInInspector]
		public long serverIntervalSentBytes;

		[global::UnityEngine.HideInInspector]
		public int serverReceivedPacketsPerSecond;

		[global::UnityEngine.HideInInspector]
		public long serverReceivedBytesPerSecond;

		[global::UnityEngine.HideInInspector]
		public int serverSentPacketsPerSecond;

		[global::UnityEngine.HideInInspector]
		public long serverSentBytesPerSecond;

		private void Start()
		{
			global::Mirror.Transport active = global::Mirror.Transport.active;
			if (active != null)
			{
				active.OnClientDataReceived = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(active.OnClientDataReceived, new global::System.Action<global::System.ArraySegment<byte>, int>(OnClientReceive));
				active.OnClientDataSent = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(active.OnClientDataSent, new global::System.Action<global::System.ArraySegment<byte>, int>(OnClientSend));
				active.OnServerDataReceived = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(active.OnServerDataReceived, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnServerReceive));
				active.OnServerDataSent = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(active.OnServerDataSent, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnServerSend));
			}
			else
			{
				global::UnityEngine.Debug.LogError($"NetworkStatistics: no available or active Transport found on this platform: {(global::UnityEngine.Application.platform)}");
			}
		}

		private void OnDestroy()
		{
			global::Mirror.Transport active = global::Mirror.Transport.active;
			if (active != null)
			{
				active.OnClientDataReceived = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(active.OnClientDataReceived, new global::System.Action<global::System.ArraySegment<byte>, int>(OnClientReceive));
				active.OnClientDataSent = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(active.OnClientDataSent, new global::System.Action<global::System.ArraySegment<byte>, int>(OnClientSend));
				active.OnServerDataReceived = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(active.OnServerDataReceived, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnServerReceive));
				active.OnServerDataSent = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(active.OnServerDataSent, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnServerSend));
			}
		}

		private void OnClientReceive(global::System.ArraySegment<byte> data, int channelId)
		{
			clientIntervalReceivedPackets++;
			clientIntervalReceivedBytes += data.Count;
		}

		private void OnClientSend(global::System.ArraySegment<byte> data, int channelId)
		{
			clientIntervalSentPackets++;
			clientIntervalSentBytes += data.Count;
		}

		private void OnServerReceive(int connectionId, global::System.ArraySegment<byte> data, int channelId)
		{
			serverIntervalReceivedPackets++;
			serverIntervalReceivedBytes += data.Count;
		}

		private void OnServerSend(int connectionId, global::System.ArraySegment<byte> data, int channelId)
		{
			serverIntervalSentPackets++;
			serverIntervalSentBytes += data.Count;
		}

		private void Update()
		{
			if (global::Mirror.NetworkTime.localTime >= intervalStartTime + 1.0)
			{
				if (global::Mirror.NetworkClient.active)
				{
					UpdateClient();
				}
				if (global::Mirror.NetworkServer.active)
				{
					UpdateServer();
				}
				intervalStartTime = global::Mirror.NetworkTime.localTime;
			}
		}

		private void UpdateClient()
		{
			clientReceivedPacketsPerSecond = clientIntervalReceivedPackets;
			clientReceivedBytesPerSecond = clientIntervalReceivedBytes;
			clientSentPacketsPerSecond = clientIntervalSentPackets;
			clientSentBytesPerSecond = clientIntervalSentBytes;
			clientIntervalReceivedPackets = 0;
			clientIntervalReceivedBytes = 0L;
			clientIntervalSentPackets = 0;
			clientIntervalSentBytes = 0L;
		}

		private void UpdateServer()
		{
			serverReceivedPacketsPerSecond = serverIntervalReceivedPackets;
			serverReceivedBytesPerSecond = serverIntervalReceivedBytes;
			serverSentPacketsPerSecond = serverIntervalSentPackets;
			serverSentBytesPerSecond = serverIntervalSentBytes;
			serverIntervalReceivedPackets = 0;
			serverIntervalReceivedBytes = 0L;
			serverIntervalSentPackets = 0;
			serverIntervalSentBytes = 0L;
		}
	}
}
