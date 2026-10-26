namespace Mirror
{
	public static class HostMode
	{
		internal static void SetupConnections()
		{
			global::Mirror.Utils.CreateLocalConnections(out var connectionToClient, out var connectionToServer);
			global::Mirror.NetworkClient.connection = connectionToServer;
			global::Mirror.NetworkServer.SetLocalConnection(connectionToClient);
		}

		public static void InvokeOnConnected()
		{
			global::Mirror.NetworkServer.OnConnected(global::Mirror.NetworkServer.localConnection);
			((global::Mirror.LocalConnectionToServer)global::Mirror.NetworkClient.connection).QueueConnectedEvent();
		}

		[global::System.Obsolete("ActivateHostScene did nothing, since identities all had .isClient set in NetworkServer.SpawnObjects.")]
		public static void ActivateHostScene()
		{
		}
	}
}
