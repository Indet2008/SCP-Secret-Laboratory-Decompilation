using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.UI;

// Rebuilt from the 14.2.8 client disassembly (party pre-lobby in the main menu).
public class SteamPreLobby : MonoBehaviour
{
	public GameObject root;

	public GameObject Counter;

	public GameObject LeaveButton;

	public Animator SlotAnim;

	public UnityEngine.UI.Image Host;

	public UnityEngine.UI.Image[] Friends;

	public Sprite InviteButton;

	public RectTransform ScrollView;

	public RectTransform Content;

	public RectTransform Element;

	private List<GameObject> _elements = new List<GameObject>();

	private static readonly int _bTrigger = Animator.StringToHash("bTrigger");

	public void InviteFriend()
	{
		SteamLobby.singleton.CreateLobby(20, preLobby: true);
		LeaveButton.SetActive(value: true);
	}

	public void OnMemberJoined(Friend friend)
	{
		RefreshList(SteamLobby.singleton.Lobby);
	}

	public void OnMemberLeave(Friend friend)
	{
		RefreshList(SteamLobby.singleton.Lobby);
	}

	public void OnJoinLobby(Lobby lobby)
	{
		RefreshList(lobby);
		LeaveButton.SetActive(value: true);
	}

	public void OnAnimOver()
	{
		Counter.SetActive(SlotAnim.GetBool(_bTrigger));
	}

	public void OnCounterClick()
	{
		ScrollView.gameObject.SetActive(!ScrollView.gameObject.activeSelf);
	}

	public void Leave()
	{
		SteamLobby.singleton.Lobby.Leave();
		LeaveButton.SetActive(value: false);
		ResetSlots();
	}

	private void Start()
	{
		root.SetActive(SteamManager.Running);
		if (SteamManager.Running)
		{
			SetAvatar(Host, SteamClient.SteamId);
			Host.GetComponent<FriendInfo>().SteamId = SteamClient.SteamId;
		}
	}

	private void ResetSlots()
	{
		UnityEngine.UI.Image[] friends = Friends;
		foreach (UnityEngine.UI.Image image in friends)
		{
			image.sprite = InviteButton;
			image.GetComponent<FriendInfo>().Clear();
		}
		SetAvatar(Host, SteamClient.SteamId);
		Host.GetComponent<FriendInfo>().SteamId = SteamClient.SteamId;
	}

	internal void RefreshList(Lobby lobby)
	{
		foreach (GameObject element in _elements)
		{
			Object.Destroy(element);
		}
		_elements.Clear();
		ResetSlots();
		Debug.Log("[RefreshList]lobby:" + lobby.Id.Value + " IsPre:" + lobby.GetData("IsPreLobby"));
		if (lobby.GetData("IsPreLobby") != "true")
		{
			return;
		}
		Friend owner = lobby.Owner;
		SetAvatar(Host, owner.Id);
		FriendInfo component = Host.GetComponent<FriendInfo>();
		component.SteamId = owner.Id;
		component.Username = owner.Name;
		Counter.GetComponentInChildren<TMPro.TextMeshProUGUI>().text = (lobby.MemberCount - 1).ToString();
		if (lobby.MemberCount < 5)
		{
			SlotAnim.SetBool(_bTrigger, value: false);
			int num = 0;
			foreach (Friend member in lobby.Members)
			{
				if (!member.Id.Equals(owner.Id) && num < Friends.Length)
				{
					SetAvatar(Friends[num], member.Id);
					FriendInfo component2 = Friends[num].GetComponent<FriendInfo>();
					component2.SteamId = member.Id;
					component2.Username = member.Name;
					num++;
				}
			}
			return;
		}
		SlotAnim.SetBool(_bTrigger, value: true);
		foreach (Friend member2 in lobby.Members)
		{
			if (!member2.Id.Equals(owner.Id))
			{
				AddElement(member2);
			}
		}
	}

	private void AddElement(Friend friend)
	{
		RectTransform rectTransform = Object.Instantiate(Element, Content, worldPositionStays: true);
		_elements.Add(rectTransform.gameObject);
		SetAvatar(rectTransform.GetComponentInChildren<UnityEngine.UI.Image>(), friend.Id);
		FriendInfo component = rectTransform.GetComponent<FriendInfo>();
		component.SteamId = friend.Id;
		component.Username = friend.Name;
	}

	private async void SetAvatar(UnityEngine.UI.Image image, SteamId steamid)
	{
		Steamworks.Data.Image? image2 = await SteamFriends.GetLargeAvatarAsync(steamid);
		if (image2.HasValue && !(image == null))
		{
			Steamworks.Data.Image value = image2.Value;
			Texture2D texture2D = new Texture2D((int)value.Width, (int)value.Height, TextureFormat.RGBA32, mipChain: false);
			for (int i = 0; i < value.Width; i++)
			{
				for (int j = 0; j < value.Height; j++)
				{
					Steamworks.Data.Color pixel = value.GetPixel(i, j);
					texture2D.SetPixel(i, (int)value.Height - j - 1, new Color32(pixel.r, pixel.g, pixel.b, pixel.a));
				}
			}
			texture2D.Apply();
			image.sprite = Sprite.Create(texture2D, new Rect(0f, 0f, texture2D.width, texture2D.height), new Vector2(0.5f, 0.5f));
		}
	}
}
