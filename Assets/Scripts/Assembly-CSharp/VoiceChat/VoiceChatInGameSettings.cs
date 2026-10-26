using UnityEngine;

namespace VoiceChat
{
	public class VoiceChatInGameSettings : MonoBehaviour
	{
		[SerializeField]
		private GameObject _acceptedRoot;

		[SerializeField]
		private GameObject _deniedRoot;

		[SerializeField]
		private bool _updateEveryFrame;

		private void Awake()
		{
			UpdateSettings();
			VoiceChatPrivacySettings.OnUserFlagsChanged += OnUserFlagsChanged;
		}

		private void OnDestroy()
		{
			VoiceChatPrivacySettings.OnUserFlagsChanged -= OnUserFlagsChanged;
		}

		private void Update()
		{
			if (_updateEveryFrame)
			{
				UpdateSettings();
			}
		}

		private void OnUserFlagsChanged(ReferenceHub hub)
		{
			if (hub.isLocalPlayer)
			{
				UpdateSettings();
			}
		}

		private void UpdateSettings()
		{
			bool flag = (VoiceChatPrivacySettings.PrivacyFlags & VcPrivacyFlags.AllowMicCapture) == VcPrivacyFlags.AllowMicCapture;
			_acceptedRoot.SetActive(flag);
			_deniedRoot.SetActive(!flag);
		}

		public void ShowPrivacySettings()
		{
		}
	}
}
