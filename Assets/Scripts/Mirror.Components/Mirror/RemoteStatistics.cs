namespace Mirror
{
	public class RemoteStatistics : global::Mirror.NetworkBehaviour
	{
		protected global::Mirror.NetworkStatistics NetworkStatistics;

		[global::UnityEngine.Tooltip("Send stats every 'interval' seconds to client.")]
		public float sendInterval = 1f;

		private double lastSendTime;

		[global::UnityEngine.Header("GUI")]
		public bool showGui;

		public global::UnityEngine.KeyCode hotKey = global::UnityEngine.KeyCode.F11;

		private global::UnityEngine.Rect windowRect = new global::UnityEngine.Rect(0f, 0f, 400f, 400f);

		[global::UnityEngine.Header("Authentication")]
		public string passwordFile = "remote_statistics.txt";

		protected bool serverAuthenticated;

		protected bool clientAuthenticated;

		protected string serverPassword;

		protected string clientPassword = "";

		private global::Mirror.Stats stats;

		private void LoadPassword()
		{
			string fullPath = global::System.IO.Path.GetFullPath(passwordFile);
			if (global::System.IO.File.Exists(fullPath))
			{
				try
				{
					serverPassword = global::System.IO.File.ReadAllText(fullPath);
					return;
				}
				catch (global::System.Exception arg)
				{
					global::UnityEngine.Debug.LogWarning($"RemoteStatistics: failed to read password file: {arg}");
					return;
				}
			}
			global::UnityEngine.Debug.LogWarning("RemoteStatistics: password file has not been created. Authentication will be impossible. Please save the password in: " + fullPath);
		}

		protected override void OnValidate()
		{
			base.OnValidate();
			syncMode = global::Mirror.SyncMode.Owner;
		}

		public override void OnStartServer()
		{
			NetworkStatistics = global::Mirror.NetworkManager.singleton.GetComponent<global::Mirror.NetworkStatistics>();
			if (NetworkStatistics == null)
			{
				throw new global::System.Exception("RemoteStatistics requires a NetworkStatistics component on " + global::Mirror.NetworkManager.singleton.name + "!");
			}
			LoadPassword();
		}

		public override void OnStartLocalPlayer()
		{
			windowRect.x = (float)(global::UnityEngine.Screen.width / 2) - windowRect.width / 2f;
			windowRect.y = (float)(global::UnityEngine.Screen.height / 2) - windowRect.height / 2f;
		}

		[global::Mirror.TargetRpc]
		private void TargetRpcSync(global::Mirror.Stats v)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			global::Mirror.GeneratedNetworkCode._Write_Mirror_002EStats(writer, v);
			SendTargetRPCInternal(null, "System.Void Mirror.RemoteStatistics::TargetRpcSync(Mirror.Stats)", 1857970636, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		public void CmdAuthenticate(string v)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteString(v);
			SendCommandInternal("System.Void Mirror.RemoteStatistics::CmdAuthenticate(System.String)", -1315927130, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		private void UpdateServer()
		{
			if (serverAuthenticated && global::Mirror.NetworkTime.localTime >= lastSendTime + (double)sendInterval)
			{
				lastSendTime = global::Mirror.NetworkTime.localTime;
				TargetRpcSync(new global::Mirror.Stats(global::Mirror.NetworkServer.connections.Count, global::Mirror.NetworkTime.time, global::Mirror.NetworkServer.tickRate, global::Mirror.NetworkServer.actualTickRate, NetworkStatistics.serverSentBytesPerSecond, NetworkStatistics.serverReceivedBytesPerSecond, global::Mirror.NetworkServer.tickInterval, global::Mirror.NetworkServer.fullUpdateDuration.average, global::Mirror.NetworkServer.earlyUpdateDuration.average, global::Mirror.NetworkServer.lateUpdateDuration.average, 0.0, 0.0));
			}
		}

		private void UpdateClient()
		{
		}

		private void Update()
		{
			if (base.isServer)
			{
				UpdateServer();
			}
			if (base.isLocalPlayer)
			{
				UpdateClient();
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_TargetRpcSync__Stats(global::Mirror.Stats v)
		{
			clientAuthenticated = true;
			stats = v;
		}

		protected static void InvokeUserCode_TargetRpcSync__Stats(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("TargetRPC TargetRpcSync called on server.");
			}
			else
			{
				((global::Mirror.RemoteStatistics)obj).UserCode_TargetRpcSync__Stats(global::Mirror.GeneratedNetworkCode._Read_Mirror_002EStats(reader));
			}
		}

		protected void UserCode_CmdAuthenticate__String(string v)
		{
			if (!string.IsNullOrWhiteSpace(serverPassword) && serverPassword.Equals(v))
			{
				serverAuthenticated = true;
				global::UnityEngine.Debug.Log($"RemoteStatistics: connectionId {base.connectionToClient.connectionId} authenticated with player {base.name}");
			}
		}

		protected static void InvokeUserCode_CmdAuthenticate__String(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdAuthenticate called on client.");
			}
			else
			{
				((global::Mirror.RemoteStatistics)obj).UserCode_CmdAuthenticate__String(reader.ReadString());
			}
		}

		static RemoteStatistics()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.RemoteStatistics), "System.Void Mirror.RemoteStatistics::CmdAuthenticate(System.String)", InvokeUserCode_CmdAuthenticate__String, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.RemoteStatistics), "System.Void Mirror.RemoteStatistics::TargetRpcSync(Mirror.Stats)", InvokeUserCode_TargetRpcSync__Stats);
		}
	}
}
