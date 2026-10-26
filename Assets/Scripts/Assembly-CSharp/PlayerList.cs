using System;
using System.Collections.Generic;
using CentralAuth;
using GameCore;
using MEC;
using Mirror;
using ToggleableMenus;
using UnityEngine;
using Utils.ConfigHandler;

public class PlayerList : SimpleToggleableMenu
{
	public global::TMPro.TextMeshProUGUI badgeText;

	public global::TMPro.TextMeshProUGUI timerText;

	public global::TMPro.TextMeshProUGUI serverNameText;

	public global::TMPro.TextMeshProUGUI reportPopupText;

	public global::TMPro.TextMeshProUGUI PlayerCount;


	[Serializable]
	public class Instance
	{
		public ReferenceHub owner;

		public PlayerListElement listElementReference;
	}

	public static readonly ConfigEntry<float> RefreshRate = new ConfigEntry<float>("player_list_title_rate", 5f, "Player List Title Refresh Rate", "The amount of time (in seconds) between refreshing the title of the player list");

	public static readonly ConfigEntry<string> Title = new ConfigEntry<string>("player_list_title", null, "Player List Title", "The title at the top of the player list menu.");

	public Transform parent;

	public Transform template;

	public GameObject mainPanel;

	public GameObject reportForm;

	public GameObject reportPopup;

	public static InterfaceColorAdjuster ica;

	public static PlayerList singleton;

	private int _timer;

	private static Transform s_parent;

	private static Transform s_template;

	private static bool _anyAdminOnServer;

	public static readonly List<Instance> instances = new List<Instance>();

	private static string ServerName
	{
		get
		{
			ServerConfigSynchronizer serverConfigSynchronizer = ServerConfigSynchronizer.Singleton;
			if (!(serverConfigSynchronizer == null))
			{
				return serverConfigSynchronizer.ServerName;
			}
			return null;
		}
		set
		{
			if (!(ServerConfigSynchronizer.Singleton == null))
			{
				ServerConfigSynchronizer.Singleton.NetworkServerName = value;
			}
		}
	}

	private const float ListRefreshInterval = 0.5f;

	private float _listRefreshTimer;

	private void Update()
	{
		RectTransform component = GetComponent<RectTransform>();
		component.localPosition = Vector3.zero;
		component.sizeDelta = Vector2.zero;
		_listRefreshTimer -= Time.unscaledDeltaTime;
		if (_listRefreshTimer <= 0f)
		{
			_listRefreshTimer = ListRefreshInterval;
			RefreshList();
		}
	}

	protected override void OnToggled()
	{
		base.OnToggled();
		if (mainPanel != null)
		{
			mainPanel.SetActive(IsEnabled);
		}
		if (!IsEnabled)
		{
			CloseForm();
			return;
		}
		_listRefreshTimer = 0f;
		RefreshList();
		UpdateColors();
	}

	public void CloseForm()
	{
		if (reportForm != null)
		{
			reportForm.SetActive(value: false);
		}
		if (reportPopup != null)
		{
			reportPopup.SetActive(value: false);
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		ReferenceHub.OnPlayerRemoved -= DestroyPlayer;
		if (singleton == this)
		{
			singleton = null;
		}
	}

	// because the hub's mode, nickname and badge all arrive through separate syncvars after OnPlayerAdded.
	private static bool ShouldBeListed(ReferenceHub hub)
	{
		if (hub == null || hub.Mode == ClientInstanceMode.DedicatedServer || hub.IsDummy)
		{
			return false;
		}
		return !hub.serverRoles.HideFromPlayerList || hub.isLocalPlayer;
	}

	private void RefreshList()
	{
		for (int i = instances.Count - 1; i >= 0; i--)
		{
			Instance instance = instances[i];
			if (instance.owner == null || !ShouldBeListed(instance.owner))
			{
				RemoveInstance(i);
			}
		}
		int listed = 0;
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			if (ShouldBeListed(allHub))
			{
				listed++;
				AddPlayer(allHub);
			}
		}
		foreach (Instance instance2 in instances)
		{
			RefreshElement(instance2);
		}
		if (PlayerCount != null)
		{
			PlayerCount.text = listed.ToString();
		}
		if (serverNameText != null && ServerName != null)
		{
			serverNameText.text = ServerName;
		}
		if (timerText != null)
		{
			timerText.text = RoundStart.RoundLength.ToString("hh\\:mm\\:ss");
		}
	}

	private static void RefreshElement(Instance instance)
	{
		PlayerListElement element = instance.listElementReference;
		ReferenceHub owner = instance.owner;
		if (element == null || owner == null)
		{
			return;
		}
		element.instance = owner;
		element.TextNick.text = owner.nicknameSync.DisplayName;
		ServerRoles serverRoles = owner.serverRoles;
		string badge = serverRoles.GetUncoloredRoleString();
		element.TextBadge.text = badge;
		Color color = serverRoles.GetColor();
		element.TextBadge.color = ((color.a > 0f) ? color : Color.white);
		if (element.ImgVerified != null)
		{
			element.ImgVerified.gameObject.SetActive(!string.IsNullOrEmpty(serverRoles.GlobalBadge));
		}
		if (element.ToggleMute != null)
		{
			element.ToggleMute.gameObject.SetActive(!owner.isLocalPlayer);
		}
	}

	public static void AddPlayer(ReferenceHub hub)
	{
		if (s_template == null || s_parent == null || !ShouldBeListed(hub))
		{
			return;
		}
		foreach (Instance instance in instances)
		{
			if (instance.owner == hub)
			{
				return;
			}
		}
		Transform transform = UnityEngine.Object.Instantiate(s_template, s_parent);
		transform.localScale = Vector3.one;
		transform.gameObject.SetActive(value: true);
		PlayerListElement component = transform.GetComponent<PlayerListElement>();
		component.instance = hub;
		Instance item = new Instance
		{
			owner = hub,
			listElementReference = component
		};
		instances.Add(item);
		RefreshElement(item);
		ApplyInterfaceColor(component);
	}

	public static void UpdateColors()
	{
		foreach (Instance instance in instances)
		{
			ApplyInterfaceColor(instance.listElementReference);
		}
	}

	private static void ApplyInterfaceColor(PlayerListElement element)
	{
		if (!(element == null) && !(element.ImgBackground == null) && !(ica == null))
		{
			Color currentColor = ica.CurrentColor;
			currentColor.a = element.ImgBackground.color.a;
			element.ImgBackground.color = currentColor;
		}
	}

	public static void DestroyPlayer(ReferenceHub hub)
	{
		for (int i = instances.Count - 1; i >= 0; i--)
		{
			if (instances[i].owner == hub)
			{
				RemoveInstance(i);
			}
		}
	}

	private static void RemoveInstance(int index)
	{
		PlayerListElement listElementReference = instances[index].listElementReference;
		if (listElementReference != null)
		{
			UnityEngine.Object.Destroy(listElementReference.gameObject);
		}
		instances.RemoveAt(index);
	}

	private void Start()
	{
		_anyAdminOnServer = false;
		if (NetworkServer.active)
		{
			ConfigFile.ServerConfig.UpdateConfigValue(RefreshRate);
			ConfigFile.ServerConfig.UpdateConfigValue(Title);
			Timing.RunCoroutine(_RefreshTitleLoop(), Segment.FixedUpdate);
		}
	}

	protected override void Awake()
	{
		base.Awake();
		instances.Clear();
		singleton = this;
		s_parent = parent;
		s_template = template;
		ReferenceHub.OnPlayerRemoved += DestroyPlayer;
	}

	public static void UpdatePlayerNickname(ReferenceHub instance)
	{
		foreach (Instance instance2 in instances)
		{
			if (!(instance2.owner == null) && !(instance2.owner != instance))
			{
				ReferenceHub hub = ReferenceHub.GetHub(instance2.owner);
				if (instance2.listElementReference != null && hub != null)
				{
					instance2.listElementReference.TextNick.text = hub.nicknameSync.DisplayName;
				}
				else
				{
					Debug.LogWarning("UpdatePlayerNickname: PlayerList Instance either has a null list element or is updating for an unknown player.");
				}
				break;
			}
		}
	}

	public static void UpdatePlayerRole(ReferenceHub instance)
	{
		_anyAdminOnServer = false;
		bool flag = instance == null;
		foreach (Instance instance2 in instances)
		{
			try
			{
				if (instance2 != null)
				{
					if (!_anyAdminOnServer && !string.IsNullOrEmpty(instance.serverRoles.GetUncoloredRoleString()))
					{
						_anyAdminOnServer = true;
					}
					if (!flag && instance == instance2.owner)
					{
						RefreshElement(instance2);
					}
				}
			}
			catch (Exception ex)
			{
				GameCore.Console.AddLog("Exception caught (UpdatePlayerRole in PlayerList): " + ex.Message, Color.red);
				Debug.LogError("Exception caught (UpdatePlayerRole in PlayerList): " + ex.Message);
			}
		}
	}

	public void RefreshTitleSafe()
	{
		string result;
		if (string.IsNullOrEmpty(Title.Value))
		{
			ServerName = ServerConsole.Singleton.RefreshServerNameSafe();
		}
		else if (!ServerConsole.Singleton.NameFormatter.TryProcessExpression(Title.Value, "player list title", out result))
		{
			ServerConsole.AddLog(result);
		}
		else
		{
			ServerName = result;
		}
	}

	public void RefreshTitle()
	{
		ServerName = (string.IsNullOrEmpty(Title.Value) ? ServerConsole.Singleton.RefreshServerName() : ServerConsole.Singleton.NameFormatter.ProcessExpression(Title.Value));
	}

	private IEnumerator<float> _RefreshTitleLoop()
	{
		while (this != null)
		{
			RefreshTitleSafe();
			ushort i = 0;
			while ((float)(int)i < 50f * RefreshRate.Value)
			{
				yield return 0f;
				i++;
			}
		}
	}
}
