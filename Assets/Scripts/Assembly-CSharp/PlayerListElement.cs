using TMPro;
using UnityEngine;
using UnityEngine.UI;
using VoiceChat;

public class PlayerListElement : MonoBehaviour
{
	public ReferenceHub instance;

	public TextMeshProUGUI TextNick;

	public TextMeshProUGUI TextBadge;

	public RawImage ImgVerified;

	public Image ImgBackground;

	public Toggle ToggleMute;

	public GameObject OpenProfile;

	private void Start()
	{
		VoiceChatMutes.OnFlagsSet += RefreshMute;
		RefreshMute(instance, VoiceChatMutes.GetFlags(instance));
	}

	private void OnDestroy()
	{
		VoiceChatMutes.OnFlagsSet -= RefreshMute;
	}

	private void RefreshMute(ReferenceHub hub, VcMuteFlags flags)
	{
		if (!(hub != instance) && ReferenceHub.AllHubs.Contains(hub))
		{
			ToggleMute.SetIsOnWithoutNotify(flags != VcMuteFlags.None);
		}
	}

	private string TargetUserId
	{
		get
		{
			if (instance == null)
			{
				return null;
			}
			string userId = instance.authManager.UserId;
			if (!string.IsNullOrEmpty(userId))
			{
				return userId;
			}
			return instance.authManager.SyncedUserId;
		}
	}

	public void Mute(bool b)
	{
		string targetUserId = TargetUserId;
		if (string.IsNullOrEmpty(targetUserId) || instance.isLocalPlayer)
		{
			return;
		}
		if (b)
		{
			VoiceChatMutes.IssueLocalMute(targetUserId);
		}
		else
		{
			VoiceChatMutes.RevokeLocalMute(targetUserId);
		}
	}

	public void OpenSteamAccount()
	{
		string targetUserId = TargetUserId;
		if (!string.IsNullOrEmpty(targetUserId) && targetUserId.EndsWith("@steam", System.StringComparison.Ordinal))
		{
			Application.OpenURL("https://steamcommunity.com/profiles/" + targetUserId.Substring(0, targetUserId.Length - 6));
		}
	}

	public void Report()
	{
		if (PlayerList.singleton != null && PlayerList.singleton.reportForm != null)
		{
			PlayerList.singleton.reportForm.SetActive(value: true);
		}
	}
}
