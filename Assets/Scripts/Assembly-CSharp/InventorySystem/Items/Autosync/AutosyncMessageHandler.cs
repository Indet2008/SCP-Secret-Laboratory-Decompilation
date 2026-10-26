using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Autosync
{
	public static class AutosyncMessageHandler
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler<AutosyncMessage>(ServerHandleAutosyncCmd);
				NetworkClient.ReplaceHandler<AutosyncMessage>(ClientHandleAutosyncRpc);
			};
		}

		private static void ClientHandleAutosyncRpc(AutosyncMessage msg)
		{
			try
			{
				msg.ProcessRpc();
			}
			catch (Exception exception)
			{
				Debug.Log("Exception in AutoSync RPC handler for " + msg);
				Debug.LogException(exception);
			}
		}

		private static void ServerHandleAutosyncCmd(NetworkConnection conn, AutosyncMessage msg)
		{
			if (!(conn.identity == null) && ReferenceHub.TryGetHub(conn, out var hub))
			{
				msg.ProcessCmd(hub);
			}
		}

		public static AutosyncMessage ReadAutosyncMessage(this NetworkReader reader)
		{
			return new AutosyncMessage(reader);
		}

		public static void WriteAutosyncMessage(this NetworkWriter writer, AutosyncMessage msg)
		{
			msg.Serialize(writer);
		}
	}
}
