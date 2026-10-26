using Mirror;
using UnityEngine;

namespace VoiceChat
{
	public class VoiceChatMuteIndicator : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _root;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _locally;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _globally;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _unauthed;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _privacy;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TextMeshProUGUI _privacyText;


		public struct SyncMuteMessage : NetworkMessage
		{
			public byte Flags;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<SyncMuteMessage>(ReceiveMessage);
			};
			VoiceChatMutes.OnFlagsSet += (ReferenceHub hub, VcMuteFlags flags) =>
			{
				if (NetworkServer.active)
				{
					hub.connectionToClient.Send(new SyncMuteMessage
					{
						Flags = (byte)flags
					});
				}
			};
		}

		private static void ReceiveMessage(SyncMuteMessage smm)
		{
		}
	}
}
