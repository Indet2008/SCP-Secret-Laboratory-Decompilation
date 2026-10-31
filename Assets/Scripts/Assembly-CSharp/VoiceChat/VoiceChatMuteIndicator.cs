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

		private static VoiceChatMuteIndicator _singleton;

		private const VcMuteFlags Filter = VcMuteFlags.LocalRegular | VcMuteFlags.GlobalRegular;

		public static VcMuteFlags ReceivedFlags { get; private set; }

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
			VoiceChatPrivacySettings.OnUserFlagsChanged += RefreshIndicator;
			global::CentralAuth.PlayerAuthenticationManager.OnInstanceModeChanged += (ReferenceHub hub, global::CentralAuth.ClientInstanceMode mode) =>
			{
				RefreshIndicator(hub);
			};
		}

		private static void ReceiveMessage(SyncMuteMessage smm)
		{
			ReceivedFlags = (VcMuteFlags)(smm.Flags & 5);
			if (_singleton != null)
			{
				_singleton.RefreshIndicator();
			}
		}

		private void Start()
		{
			_singleton = this;
			RefreshIndicator();
		}

		private static void RefreshIndicator(ReferenceHub hub)
		{
			if (hub.isLocalPlayer && _singleton != null)
			{
				_singleton.RefreshIndicator();
			}
		}

		private void RefreshIndicator()
		{
			if ((VoiceChatPrivacySettings.PrivacyFlags & VcPrivacyFlags.AllowMicCapture) == 0)
			{
				_locally.SetActive(value: false);
				_globally.SetActive(value: false);
				_unauthed.SetActive(value: false);
				_root.SetActive(value: true);
				_privacy.SetActive(value: true);
				_privacyText.text = TranslationReader.GetFormatted("Voicechat", 18, "Press \"{0}\" and navigate to \"Settings\" to adjust.", new ReadableKeyCode(NewInput.GetKey(ActionName.PauseMenu)));
				return;
			}
			_privacy.SetActive(value: false);
			switch (ReceivedFlags)
			{
			case VcMuteFlags.None:
				if (ReferenceHub.TryGetLocalHub(out var hub) && hub.authManager.InstanceMode != global::CentralAuth.ClientInstanceMode.Unverified)
				{
					_root.SetActive(value: false);
					break;
				}
				_root.SetActive(value: true);
				_locally.SetActive(value: false);
				_globally.SetActive(value: false);
				_unauthed.SetActive(value: true);
				break;
			case VcMuteFlags.LocalRegular:
				_root.SetActive(value: true);
				_locally.SetActive(value: true);
				_globally.SetActive(value: false);
				_unauthed.SetActive(value: false);
				break;
			case VcMuteFlags.GlobalRegular:
				_root.SetActive(value: true);
				_locally.SetActive(value: false);
				_globally.SetActive(value: true);
				_unauthed.SetActive(value: false);
				break;
			}
		}
	}
}
