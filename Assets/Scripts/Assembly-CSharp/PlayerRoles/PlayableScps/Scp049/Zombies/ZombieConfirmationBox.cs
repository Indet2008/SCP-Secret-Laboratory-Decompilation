using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieConfirmationBox : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _progressBar;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _root;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _text;


		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct ScpReviveBlockMessage : NetworkMessage
		{
		}

		private static void ServerReceiveMessage(NetworkConnection conn)
		{
			if (NetworkServer.active && ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub) && Scp049ResurrectAbility.GetResurrectionsNumber(hub) != 0)
			{
				Scp049ResurrectAbility.RegisterPlayerResurrection(hub, 2);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, ScpReviveBlockMessage msg) =>
				{
					ServerReceiveMessage(conn);
				});
			};
		}
	}
}
