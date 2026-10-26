using CursorManagement;
using Mirror;
using UnityEngine;
using UnityEngine.UI;
using VoiceChat;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryConfirmationBox : MonoBehaviour, ICursorOverride
	{
		private const string PrefsKey = "MimicryRememberChoice";

		[SerializeField]
		private GameObject _moreInfoRoot;

		[SerializeField]
		private Image _progress;

		[SerializeField]
		private float _duration;

		[SerializeField]
		private Canvas _hideHudCanvas;

		[SerializeField]
		private Toggle _rememberToggle;

		public static bool Remember
		{
			get
			{
				return PlayerPrefsSl.Get("MimicryRememberChoice", defaultValue: false);
			}
			set
			{
				PlayerPrefsSl.Set("MimicryRememberChoice", value);
			}
		}

		public CursorOverrideMode CursorOverride => CursorOverrideMode.Free;

		public bool LockMovement => false;

		public void ButtonOk()
		{
			if (_rememberToggle.isOn)
			{
				Remember = true;
			}
			Object.Destroy(base.gameObject);
		}

		public void ButtonDelete()
		{
			VcPrivacyFlags vcPrivacyFlags = VoiceChatPrivacySettings.PrivacyFlags & ~VcPrivacyFlags.AllowRecording;
			if (_rememberToggle.isOn)
			{
				VoiceChatPrivacySettings.PrivacyFlags = vcPrivacyFlags;
				VoiceChatPrivacySettings.Singleton.UpdateToggles();
			}
			NetworkClient.Send(new VoiceChatPrivacySettings.VcPrivacyMessage
			{
				Flags = (byte)vcPrivacyFlags
			});
			Object.Destroy(base.gameObject);
		}

		private void Update()
		{
			if (_moreInfoRoot.activeSelf)
			{
				_progress.fillAmount = 1f;
				return;
			}
			_progress.fillAmount -= Time.deltaTime / _duration;
			if (!(_progress.fillAmount > 0f))
			{
				Object.Destroy(base.gameObject);
			}
		}
	}
}
