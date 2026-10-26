public class SteamPreLobby : global::UnityEngine.MonoBehaviour
{

	public global::UnityEngine.GameObject root;

	public global::UnityEngine.GameObject Counter;

	public global::UnityEngine.GameObject LeaveButton;

	public global::UnityEngine.Animator SlotAnim;

	public global::UnityEngine.UI.Image Host;

	public global::UnityEngine.UI.Image[] Friends;

	public global::UnityEngine.Sprite InviteButton;

	public global::UnityEngine.RectTransform ScrollView;

	public global::UnityEngine.RectTransform Content;

	public global::UnityEngine.RectTransform Element;

	private global::System.Collections.Generic.List<global::UnityEngine.GameObject> _elements;

	private static readonly int _bTrigger;

	public void InviteFriend()
	{
	}

	public void OnMemberJoined(global::Steamworks.Friend friend)
	{
	}

	public void OnMemberLeave(global::Steamworks.Friend friend)
	{
	}

	public void OnJoinLobby(global::Steamworks.Data.Lobby lobby)
	{
	}

	public void OnAnimOver()
	{
	}

	public void OnCounterClick()
	{
	}

	public void Leave()
	{
	}

	private void Start()
	{
	}

	private void RefreshList(global::Steamworks.Data.Lobby lobby)
	{
	}

	private void AddElement(global::Steamworks.Friend friend)
	{
	}

	private void SetAvatar(global::UnityEngine.UI.Image image, global::Steamworks.SteamId steamid)
	{
	}

	public SteamPreLobby()
	{
	}
}
