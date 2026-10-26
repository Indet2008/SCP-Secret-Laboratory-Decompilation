using Interactables.Verification;
using Mirror;
using Mirror.RemoteCalls;
using TMPro;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class TestInterobject : NetworkBehaviour, IClientInteractable, IInteractable, IServerInteractable
	{
		public TextMeshProUGUI ClientText;

		public TextMeshProUGUI GlobalText;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		[Client]
		public void ClientInteract(InteractableCollider collider)
		{
			if (!NetworkClient.active)
			{
				Debug.LogWarning("[Client] function 'System.Void Interactables.Interobjects.TestInterobject::ClientInteract(Interactables.InteractableCollider)' called when client was not active");
				return;
			}
			ClientText.text = "Local player collider ID: " + collider.ColliderId + " (rand " + Random.value + ")";
		}

		[Server]
		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Interactables.Interobjects.TestInterobject::ServerInteract(ReferenceHub,System.Byte)' called when server was not active");
			}
			else
			{
				RpcSendText("Player " + ply.LoggedNameFromRefHub() + " interacted using collider " + colliderId);
			}
		}

		[ClientRpc]
		private void RpcSendText(string s)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteString(s);
			SendRPCInternal("System.Void Interactables.Interobjects.TestInterobject::RpcSendText(System.String)", 314358345, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcSendText__String(string s)
		{
			GlobalText.text = s;
		}

		protected static void InvokeUserCode_RpcSendText__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcSendText called on server.");
			}
			else
			{
				((TestInterobject)obj).UserCode_RpcSendText__String(reader.ReadString());
			}
		}

		static TestInterobject()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(TestInterobject), "System.Void Interactables.Interobjects.TestInterobject::RpcSendText(System.String)", InvokeUserCode_RpcSendText__String);
		}
	}
}
