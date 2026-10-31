public class FriendInfo : global::UnityEngine.MonoBehaviour
{
	public global::Steamworks.SteamId SteamId;

	public string Username;

	public void OnButtonClick()
	{
		if (SteamId.Value != 0L)
		{
			global::Steamworks.SteamFriends.OpenUserOverlay(SteamId, "steamid");
			return;
		}
		SteamPreLobby componentInParent = GetComponentInParent<SteamPreLobby>();
		SteamLobby.singleton.CreateLobby(20, preLobby: true);
		componentInParent.LeaveButton.SetActive(value: true);
	}

	public void Clear()
	{
		SteamId = default(global::Steamworks.SteamId);
		Username = string.Empty;
	}
}
