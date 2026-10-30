using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using CentralAuth;
using Cryptography;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using NetworkManagerUtils.Dummies;
using NorthwoodLib;
using PlayerRoles;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

public class ServerRoles : NetworkBehaviour
{
	[Serializable]
	public class NamedColor
	{
		public string Name;

		public string ColorHex;

		public bool Restricted;

		[SerializeField]
		private string _speakingOverride;

		private Color _speakingColorCache;

		private bool _speakingColorSet;

		public Color SpeakingColor
		{
			get
			{
				if (!_speakingColorSet)
				{
					_speakingColorSet = true;
					ColorUtility.TryParseHtmlString("#" + (string.IsNullOrEmpty(_speakingOverride) ? ColorHex : _speakingOverride), out _speakingColorCache);
				}
				return _speakingColorCache;
			}
		}
	}

	public enum BadgePreferences
	{
		NoPreference = 0,
		PreferGlobal = 1,
		PreferLocal = 2
	}

	public enum BadgeVisibilityPreferences
	{
		NoPreference = 0,
		Visible = 1,
		Hidden = 2
	}

	public NamedColor CurrentColor;

	public NamedColor[] NamedColors;

	[NonSerialized]
	private bool _bypassMode;

	private bool _authorizeBadge;

	private UserGroup _group;

	private ReferenceHub _hub;

	private static readonly Dictionary<string, NamedColor> DictionarizedColorsCache;

	private static bool _colorDictionaryCacheSet;

	private const string DefaultColor = "default";

	private const string HiddenBadgeColor = "silver";

	public const ulong UserIdPerms = 18007046uL;

	private string _globalBadgeUnconfirmed;

	private string _prevColor;

	private string _prevText;

	private string _prevBadge;

	private string _authChallenge;

	private string _badgeChallenge;

	private string _bgc;

	private string _bgt;

	private bool _requested;

	private bool _publicPartRequested;

	private bool _badgeRequested;

	private bool _authRequested;

	private bool _noclipReady;

	internal bool BadgeCover;

	[NonSerialized]
	public BadgePreferences UserBadgePreferences;

	private BadgeVisibilityPreferences _globalBadgeVisibilityPreferences;

	private BadgeVisibilityPreferences _localBadgeVisibilityPreferences;

	[SyncVar(hook = "SetTextHook")]
	private string _myText;

	[SyncVar(hook = "SetColorHook")]
	private string _myColor;

	[SyncVar]
	public string GlobalBadge;

	[SyncVar]
	public string GlobalBadgeSignature;

	[SyncVar(hook = "HidePlayerList")]
	public bool HideFromPlayerList;

	[NonSerialized]
	public bool RemoteAdmin;

	[NonSerialized]
	public ulong Permissions;

	[NonSerialized]
	public string HiddenBadge;

	[NonSerialized]
	public bool GlobalHidden;

	[NonSerialized]
	internal bool AdminChatPerms;

	[NonSerialized]
	internal ulong GlobalPerms;

	[NonSerialized]
	private bool _lastRealIdPerm;

	[NonSerialized]
	public string FixedBadge;

	public bool BypassMode
	{
		get
		{
			return _bypassMode;
		}
		set
		{
			_bypassMode = value;
			_hub.playerStats.GetModule<AdminFlagsStat>().SetFlag(AdminFlags.BypassMode, value);
		}
	}

	public bool IsInOverwatch
	{
		get
		{
			return _hub.roleManager.CurrentRole is OverwatchRole;
		}
		set
		{
			if (value != IsInOverwatch)
			{
				_hub.roleManager.ServerSetRole(value ? RoleTypeId.Overwatch : RoleTypeId.Spectator, RoleChangeReason.RemoteAdmin);
			}
		}
	}

	public UserGroup Group
	{
		get
		{
			return _group;
		}
		set
		{
			SetGroup(value);
		}
	}

	private Dictionary<string, NamedColor> NamedColorsDic
	{
		get
		{
			if (_colorDictionaryCacheSet)
			{
				return DictionarizedColorsCache;
			}
			NamedColor[] namedColors = NamedColors;
			foreach (NamedColor namedColor in namedColors)
			{
				DictionarizedColorsCache[namedColor.Name] = namedColor;
			}
			_colorDictionaryCacheSet = true;
			return DictionarizedColorsCache;
		}
	}

	internal byte KickPower
	{
		get
		{
			if (!_hub.authManager.RemoteAdminGlobalAccess)
			{
				return Group?.KickPower ?? 0;
			}
			return byte.MaxValue;
		}
	}

	public string MyColor { get; private set; }

	public string MyText { get; private set; }

	public bool GlobalSet
	{
		get
		{
			if (GlobalBadge == null)
			{
				if (MyText != null && MyText.StartsWith("[", StringComparison.Ordinal))
				{
					return MyText.EndsWith("]", StringComparison.Ordinal);
				}
				return false;
			}
			return true;
		}
	}

	private bool HasNotAllowedText
	{
		get
		{
			if (!MyText.Contains("[", StringComparison.Ordinal) && !MyText.Contains("]", StringComparison.Ordinal) && !MyText.Contains("<", StringComparison.Ordinal) && !MyText.Contains(">", StringComparison.Ordinal) && !MyText.Contains("\\u003c", StringComparison.Ordinal))
			{
				return MyText.Contains("\\u003e", StringComparison.Ordinal);
			}
			return true;
		}
	}

	public bool HasBadgeHidden
	{
		get
		{
			if (!_hub.authManager.BypassBansFlagSet)
			{
				return !string.IsNullOrEmpty(HiddenBadge);
			}
			return false;
		}
	}

	public bool HasGlobalBadge => _hub.authManager.AuthenticationResponse.SignedBadgeToken != null;

	public string Network_myText
	{
		get
		{
			return _myText;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _myText, 1uL, SetTextHook);
		}
	}

	public string Network_myColor
	{
		get
		{
			return _myColor;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _myColor, 2uL, SetColorHook);
		}
	}

	public string NetworkGlobalBadge
	{
		get
		{
			return GlobalBadge;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref GlobalBadge, 4uL, null);
		}
	}

	public string NetworkGlobalBadgeSignature
	{
		get
		{
			return GlobalBadgeSignature;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref GlobalBadgeSignature, 8uL, null);
		}
	}

	public bool NetworkHideFromPlayerList
	{
		get
		{
			return HideFromPlayerList;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref HideFromPlayerList, 16uL, HidePlayerList);
		}
	}

	private static BadgePreferences _userBadgePreferencesClient;

	private static BadgeVisibilityPreferences _globalBadgePreferencesClient;

	private static BadgeVisibilityPreferences _localBadgePreferencesClient;

	public static BadgeVisibilityPreferences GetGlobalBadgePreferences()
	{
		return _globalBadgePreferencesClient;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		_userBadgePreferencesClient = (BadgePreferences)UserSettings.UserSetting<int>.Get(UserSettings.OtherSettings.MiscPrivacySetting.BadgePreferences);
		_globalBadgePreferencesClient = (BadgeVisibilityPreferences)UserSettings.UserSetting<int>.Get((UserSettings.OtherSettings.MiscPrivacySetting)5);
		_localBadgePreferencesClient = (BadgeVisibilityPreferences)UserSettings.UserSetting<int>.Get((UserSettings.OtherSettings.MiscPrivacySetting)6);
		UserSettings.UserSetting<int>.AddListener(UserSettings.OtherSettings.MiscPrivacySetting.BadgePreferences, SetBadgePreferences);
		UserSettings.UserSetting<int>.AddListener((UserSettings.OtherSettings.MiscPrivacySetting)5, SetGlobalBadgePreferences);
		UserSettings.UserSetting<int>.AddListener((UserSettings.OtherSettings.MiscPrivacySetting)6, SetLocalBadgePreferences);
	}

	private static void SetBadgePreferences(int value)
	{
		_userBadgePreferencesClient = (BadgePreferences)value;
		ResyncPreferences();
	}

	private static void SetGlobalBadgePreferences(int value)
	{
		_globalBadgePreferencesClient = (BadgeVisibilityPreferences)value;
		ResyncPreferences();
	}

	private static void SetLocalBadgePreferences(int value)
	{
		_localBadgePreferencesClient = (BadgeVisibilityPreferences)value;
		ResyncPreferences();
	}

	private static void ResyncPreferences()
	{
		if (NetworkClient.active && ReferenceHub.TryGetLocalHub(out var hub))
		{
			hub.serverRoles.CmdSetLocalTagPreferences(_userBadgePreferencesClient, _globalBadgePreferencesClient, _localBadgePreferencesClient, refresh: true);
		}
	}

	private static string TranslateGlobalBadge(string badge, bool hidden = false)
	{
		string text = badge;
		if (!hidden)
		{
			if (!badge.StartsWith("[", System.StringComparison.Ordinal) || !badge.EndsWith("]", System.StringComparison.Ordinal))
			{
				return badge;
			}
			text = badge.Substring(1, badge.Length - 2);
		}
		if (!TranslationReader.Fallback.TryGetValue("Badges", out var value))
		{
			return badge;
		}
		int num = -1;
		for (int i = 0; i < value.Length; i++)
		{
			if (!(value[i] != text))
			{
				num = i;
				break;
			}
		}
		if (num <= -1)
		{
			return badge;
		}
		string content = (hidden ? (TranslationReader.Get("Badges", num, text) ?? string.Empty) : ("[" + TranslationReader.Get("Badges", num, text) + "]"));
		return Misc.SanitizeRichText(content, string.Empty, string.Empty);
	}

	public void Start()
	{
		_hub = ReferenceHub.GetHub(base.gameObject);
		if (_hub.IsDummy)
		{
			SetGroup(DummyUtils.DummyGroup, byAdmin: true);
		}
		if (NetworkServer.active && base.isLocalPlayer && !ServerStatic.IsDedicated)
		{
			Invoke("GrantHostPermissions", 2f);
		}
	}

	private void GrantHostPermissions()
	{
		if (NetworkServer.active && _group == null && !RemoteAdmin && ServerStatic.PermissionsHandler != null)
		{
			SetGroup(new UserGroup
			{
				Name = "host",
				BadgeText = "HOST",
				BadgeColor = "red",
				Permissions = ServerStatic.PermissionsHandler.FullPerm,
				KickPower = byte.MaxValue,
				RequiredKickPower = byte.MaxValue,
				HiddenByDefault = true
			}, byAdmin: true);
		}
	}

	[TargetRpc]
	private void TargetSetHiddenRole(NetworkConnection connection, string role)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteString(role);
		SendTargetRPCInternal(connection, "System.Void ServerRoles::TargetSetHiddenRole(Mirror.NetworkConnection,System.String)", -1356032325, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	public void RpcResetFixed()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void ServerRoles::RpcResetFixed()", 87745685, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[Command(channel = 4)]
	private void CmdSetLocalTagPreferences(BadgePreferences userPreferences, BadgeVisibilityPreferences globalPreferences, BadgeVisibilityPreferences localPreferences, bool refresh)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		GeneratedNetworkCode._Write_ServerRoles_002FBadgePreferences(writer, userPreferences);
		GeneratedNetworkCode._Write_ServerRoles_002FBadgeVisibilityPreferences(writer, globalPreferences);
		GeneratedNetworkCode._Write_ServerRoles_002FBadgeVisibilityPreferences(writer, localPreferences);
		writer.WriteBool(refresh);
		SendCommandInternal("System.Void ServerRoles::CmdSetLocalTagPreferences(ServerRoles/BadgePreferences,ServerRoles/BadgeVisibilityPreferences,ServerRoles/BadgeVisibilityPreferences,System.Boolean)", -1971566213, writer, 4);
		NetworkWriterPool.Return(writer);
	}

	[Server]
	private void RefreshGlobalBadgeVisibility(BadgeVisibilityPreferences globalPreferences)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::RefreshGlobalBadgeVisibility(ServerRoles/BadgeVisibilityPreferences)' called when server was not active");
			return;
		}
		RefreshGlobalTag();
		if (globalPreferences == BadgeVisibilityPreferences.Hidden)
		{
			TryHideTag();
		}
	}

	[Server]
	private void RefreshLocalBadgeVisibility(BadgeVisibilityPreferences localPreferences)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::RefreshLocalBadgeVisibility(ServerRoles/BadgeVisibilityPreferences)' called when server was not active");
			return;
		}
		RefreshLocalTag();
		if (localPreferences == BadgeVisibilityPreferences.Hidden)
		{
			TryHideTag();
		}
	}

	[Server]
	public void RefreshPermissions(bool disp = false)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::RefreshPermissions(System.Boolean)' called when server was not active");
			return;
		}
		UserGroup userGroup = ServerStatic.PermissionsHandler.GetUserGroup(_hub.authManager.UserId);
		if (userGroup != null)
		{
			SetGroup(userGroup, byAdmin: false, disp);
		}
	}

	[Server]
	public void SetGroup(UserGroup group, bool byAdmin = false, bool disp = false)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::SetGroup(UserGroup,System.Boolean,System.Boolean)' called when server was not active");
			return;
		}
		PlayerGroupChangingEventArgs e = new PlayerGroupChangingEventArgs(_hub, group);
		PlayerEvents.OnGroupChanging(e);
		if (!e.IsAllowed)
		{
			return;
		}
		group = e.Group;
		if (group == null)
		{
			RemoteAdmin = GlobalPerms != 0;
			Permissions = GlobalPerms;
			GlobalHidden = false;
			_group = null;
			SetColor(null);
			SetText(null);
			BadgeCover = false;
			RpcResetFixed();
			FinalizeSetGroup();
			_hub.gameConsoleTransmission.SendToClient("Your local permissions has been revoked by server administrator.", "red");
			return;
		}
		_hub.gameConsoleTransmission.SendToClient((!byAdmin) ? "Updating your group on server (local permissions)..." : "Updating your group on server (set by server administrator)...", "cyan");
		_group = group;
		BadgeCover = group.Cover;
		if ((group.Permissions | GlobalPerms) != 0 && ServerStatic.PermissionsHandler.IsRaPermitted(group.Permissions | GlobalPerms))
		{
			Permissions = group.Permissions | GlobalPerms;
			_hub.authManager.ResetPasswordAttempts();
			_hub.gameConsoleTransmission.SendToClient((!byAdmin) ? "Your remote admin access has been granted (local permissions)." : "Your remote admin access has been granted (set by server administrator).", "cyan");
		}
		else
		{
			Permissions = group.Permissions | GlobalPerms;
		}
		ServerLogs.AddLog(ServerLogs.Modules.Permissions, _hub.LoggedNameFromRefHub() + " has been assigned to group " + group.BadgeText + ".", ServerLogs.ServerLogType.ConnectionUpdate);
		if (group.BadgeColor == "none")
		{
			RpcResetFixed();
			FinalizeSetGroup();
			return;
		}
		if ((_localBadgeVisibilityPreferences == BadgeVisibilityPreferences.Hidden && !disp) || (group.HiddenByDefault && !disp && _localBadgeVisibilityPreferences != BadgeVisibilityPreferences.Visible))
		{
			BadgeCover = UserBadgePreferences == BadgePreferences.PreferLocal;
			if (!string.IsNullOrEmpty(MyText))
			{
				return;
			}
			SetText(null);
			SetColor("default");
			GlobalHidden = false;
			HiddenBadge = group.BadgeText;
			RefreshHiddenTag();
			TargetSetHiddenRole(base.connectionToClient, group.BadgeText);
			if (!byAdmin)
			{
				_hub.gameConsoleTransmission.SendToClient("Your role has been granted, but it's hidden. Use \"showtag\" command in the game console to show your server badge.", "yellow");
			}
			else
			{
				_hub.gameConsoleTransmission.SendToClient("Your role has been granted to you (set by server administrator), but it's hidden. Use \"showtag\" command in the game console to show your server badge.", "cyan");
			}
		}
		else
		{
			HiddenBadge = null;
			GlobalHidden = false;
			RpcResetFixed();
			SetText(group.BadgeText);
			SetColor(group.BadgeColor);
			if (!byAdmin)
			{
				_hub.gameConsoleTransmission.SendToClient("Your role \"" + group.BadgeText + "\" with color " + group.BadgeColor + " has been granted to you (local permissions).", "cyan");
			}
			else
			{
				_hub.gameConsoleTransmission.SendToClient("Your role \"" + group.BadgeText + "\" with color " + group.BadgeColor + " has been granted to you (set by server administrator).", "cyan");
			}
		}
		FinalizeSetGroup();
	}

	[Server]
	public void FinalizeSetGroup()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::FinalizeSetGroup()' called when server was not active");
			return;
		}
		Permissions |= GlobalPerms;
		RemoteAdmin = ServerStatic.PermissionsHandler.IsRaPermitted(Permissions | GlobalPerms);
		AdminChatPerms = PermissionsHandler.IsPermitted(Permissions, PlayerPermissions.AdminChat);
		_hub.queryProcessor.GameplayData = PermissionsHandler.IsPermitted(Permissions, PlayerPermissions.GameplayData);
		if (RemoteAdmin)
		{
			OpenRemoteAdmin();
		}
		else
		{
			TargetSetRemoteAdmin(open: false);
		}
		SendRealIds();
		bool flag = PermissionsHandler.IsPermitted(Permissions, PlayerPermissions.ViewHiddenBadges);
		bool flag2 = PermissionsHandler.IsPermitted(Permissions, PlayerPermissions.ViewHiddenGlobalBadges);
		if (flag | flag2)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.Mode != ClientInstanceMode.DedicatedServer)
				{
					ServerRoles serverRoles = allHub.serverRoles;
					if (!string.IsNullOrEmpty(serverRoles.HiddenBadge) && (!serverRoles.GlobalHidden || flag2) && (serverRoles.GlobalHidden || flag))
					{
						serverRoles.TargetSetHiddenRole(base.connectionToClient, serverRoles.HiddenBadge);
					}
				}
			}
			if (flag & flag2)
			{
				_hub.gameConsoleTransmission.SendToClient("Hidden badges (local and global) have been displayed for you (if there are any).", "gray");
			}
			else if (flag)
			{
				_hub.gameConsoleTransmission.SendToClient("Hidden badges (local only) have been displayed for you (if there are any).", "gray");
			}
			else
			{
				_hub.gameConsoleTransmission.SendToClient("Hidden badges (global only) have been displayed for you (if there are any).", "gray");
			}
		}
		PlayerEvents.OnGroupChanged(new PlayerGroupChangedEventArgs(_hub, _group));
	}

	[ServerCallback]
	public void RefreshHiddenTag()
	{
		if (!NetworkServer.active)
		{
			return;
		}
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			if (allHub.Mode != ClientInstanceMode.DedicatedServer)
			{
				ServerRoles serverRoles = allHub.serverRoles;
				bool flag = PermissionsHandler.IsPermitted(serverRoles.Permissions, PlayerPermissions.ViewHiddenBadges);
				bool flag2 = PermissionsHandler.IsPermitted(serverRoles.Permissions, PlayerPermissions.ViewHiddenGlobalBadges);
				if ((!GlobalHidden || flag2) && (GlobalHidden || flag))
				{
					TargetSetHiddenRole(serverRoles.connectionToClient, HiddenBadge);
				}
			}
		}
	}

	[Server]
	public void RefreshRealId()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::RefreshRealId()' called when server was not active");
		}
		else
		{
			if (_hub == null)
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.Mode != ClientInstanceMode.DedicatedServer && (PermissionsHandler.IsPermitted(allHub.serverRoles.Permissions, 18007046uL) || allHub.authManager.NorthwoodStaff))
				{
					_hub.authManager.TargetSetRealId(allHub.networkIdentity.connectionToClient, _hub.authManager.UserId);
				}
			}
		}
	}

	[Server]
	private void SendRealIds()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::SendRealIds()' called when server was not active");
		}
		else
		{
			if (_hub.Mode == ClientInstanceMode.DedicatedServer)
			{
				return;
			}
			bool flag = _hub.authManager.NorthwoodStaff || PermissionsHandler.IsPermitted(Permissions, 18007046uL);
			if (!flag && !_lastRealIdPerm)
			{
				return;
			}
			_lastRealIdPerm = flag;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				allHub.authManager.TargetSetRealId(_hub.networkIdentity.connectionToClient, flag ? allHub.authManager.UserId : null);
			}
		}
	}

	public string GetColoredRoleString(bool newLine = false)
	{
		if (string.IsNullOrEmpty(MyColor) || string.IsNullOrEmpty(MyText) || CurrentColor == null)
		{
			return string.Empty;
		}
		if ((CurrentColor.Restricted || HasNotAllowedText) && !_authorizeBadge)
		{
			return string.Empty;
		}
		NamedColor[] namedColors = NamedColors;
		foreach (NamedColor namedColor in namedColors)
		{
			if (namedColor.Name == MyColor)
			{
				return (newLine ? "\n" : string.Empty) + "<color=#" + namedColor.ColorHex + ">" + MyText + "</color>";
			}
		}
		return string.Empty;
	}

	public string GetUncoloredRoleString()
	{
		if (string.IsNullOrEmpty(MyText) && !string.IsNullOrEmpty(FixedBadge))
		{
			return FixedBadge;
		}
		if (string.IsNullOrEmpty(MyColor) || string.IsNullOrEmpty(MyText) || CurrentColor == null)
		{
			return string.Empty;
		}
		if ((CurrentColor.Restricted || HasNotAllowedText) && !_authorizeBadge)
		{
			return string.Empty;
		}
		return MyText;
	}

	public Color GetColor()
	{
		if (string.IsNullOrEmpty(MyColor) || !NamedColorsDic.TryGetValue(MyColor, out var value) || !ColorUtility.TryParseHtmlString("#" + value.ColorHex, out var color))
		{
			return Color.clear;
		}
		return color;
	}

	public Color GetVoiceColor()
	{
		if (string.IsNullOrEmpty(MyColor) || !NamedColorsDic.TryGetValue(MyColor, out var value))
		{
			return NamedColorsDic["default"].SpeakingColor;
		}
		return value.SpeakingColor;
	}

	private void Update()
	{
		if (!string.IsNullOrEmpty(FixedBadge) && MyText != FixedBadge)
		{
			SetText(FixedBadge);
			SetColor("silver");
			return;
		}
		if (!string.IsNullOrEmpty(FixedBadge))
		{
			NamedColor currentColor = CurrentColor;
			if (currentColor == null || !(currentColor.Name == "silver"))
			{
				SetColor("silver");
				return;
			}
		}
		if (GlobalBadge != _prevBadge)
		{
			_prevBadge = GlobalBadge;
			if (string.IsNullOrEmpty(GlobalBadge))
			{
				_bgc = null;
				_bgt = null;
				_authorizeBadge = false;
				if (_prevColor != null)
				{
					_prevColor += ".";
				}
				else
				{
					_prevColor = ".";
				}
				if (_prevText != null)
				{
					_prevText += ".";
				}
				else
				{
					_prevText = ".";
				}
				return;
			}
			GameCore.Console.AddDebugLog("SDAUTH", "Validating global badge of user " + _hub.nicknameSync.MyNick, MessageImportance.LessImportant);
			if (!new SignedToken(GlobalBadge, GlobalBadgeSignature).TryGetToken<BadgeToken>("Badge request", out var token, out var error, out var userId))
			{
				GameCore.Console.AddDebugLog("SDAUTH", "<color=red>Validation of global badge of user " + _hub.nicknameSync.MyNick + " failed - " + error + ".</color>", MessageImportance.Normal);
				_bgc = null;
				_bgt = null;
				_authorizeBadge = false;
				if (_prevColor != null)
				{
					_prevColor += ".";
				}
				else
				{
					_prevColor = ".";
				}
				if (_prevText != null)
				{
					_prevText += ".";
				}
				else
				{
					_prevText = ".";
				}
				return;
			}
			if (token.UserId != _hub.authManager.SaltedUserId && token.UserId != Sha.HashToString(Sha.Sha512(_hub.authManager.SaltedUserId)))
			{
				error = "badge token UserID mismatch.";
			}
			else if (StringUtils.Base64Decode(token.Nickname) != _hub.nicknameSync.MyNick)
			{
				error = "badge token nickname mismatch.";
			}
			if (error != null)
			{
				GameCore.Console.AddDebugLog("SDAUTH", "<color=red>Validation of global badge of user " + _hub.nicknameSync.MyNick + " failed - " + error + ".</color>", MessageImportance.Normal);
				_bgc = null;
				_bgt = null;
				_authorizeBadge = false;
				if (_prevColor != null)
				{
					_prevColor += ".";
				}
				else
				{
					_prevColor = ".";
				}
				if (_prevText != null)
				{
					_prevText += ".";
				}
				else
				{
					_prevText = ".";
				}
				return;
			}
			GameCore.Console.AddDebugLog("SDAUTH", "Validation of global badge of user " + GetComponent<NicknameSync>().MyNick + " complete - badge signed by central server " + token.IssuedBy + ".", MessageImportance.LessImportant);
			userId = token.BadgeText;
			if (userId == null || userId == "(none)")
			{
				userId = token.BadgeColor;
				if (userId == null || userId == "(none)")
				{
					_bgc = null;
					_bgt = null;
					_authorizeBadge = false;
					goto IL_03fa;
				}
			}
			_bgc = token.BadgeColor;
			SetColor(_bgc);
			if (NetworkServer.active)
			{
				_bgt = token.BadgeText;
				SetText(_bgt);
			}
			else
			{
				_bgt = TranslateGlobalBadge(token.BadgeText);
				if (_bgt != MyText)
				{
					SetText(_bgt);
					GameCore.Console.AddLog("Loaded translation for a global badge. " + token.BadgeText + ": " + MyText + " - " + _bgt + " /-/ " + MyColor + " - " + _bgc, Color.gray, nospace: true);
				}
			}
			_authorizeBadge = true;
		}
		goto IL_03fa;
		IL_03fa:
		if (!(_prevColor == MyColor) || !(_prevText == MyText))
		{
			NamedColor currentColor = CurrentColor;
			if (currentColor != null && currentColor.Restricted && (MyText != _bgt || MyColor != _bgc))
			{
				GameCore.Console.AddLog("TAG FAIL 1 - " + MyText + " - " + _bgt + " /-/ " + MyColor + " - " + _bgc, Color.gray);
				_authorizeBadge = false;
				SetColor(null);
				_prevColor = null;
				PlayerList.UpdatePlayerRole(_hub);
			}
			else if (MyText != null && MyText != _bgt && HasNotAllowedText)
			{
				GameCore.Console.AddLog("TAG FAIL 2 - " + MyText + " - " + _bgt + " /-/ " + MyColor + " - " + _bgc, Color.gray);
				_authorizeBadge = false;
				SetText(null);
				_prevText = null;
				PlayerList.UpdatePlayerRole(_hub);
			}
			else
			{
				_prevColor = MyColor;
				_prevText = MyText;
				_prevBadge = GlobalBadge;
				PlayerList.UpdatePlayerRole(_hub);
			}
		}
	}

	private void SetColorHook(string p, string i)
	{
		SetColor(i);
	}

	public void SetColor(string i)
	{
		if (string.IsNullOrEmpty(i))
		{
			i = "default";
		}
		if (NetworkServer.active)
		{
			Network_myColor = i;
		}
		MyColor = i;
		NamedColor namedColor = NamedColors.FirstOrDefault((NamedColor row) => row.Name == MyColor);
		if (namedColor == null && i != "default")
		{
			SetColor("default");
		}
		else
		{
			CurrentColor = namedColor;
		}
	}

	private void SetTextHook(string p, string i)
	{
		SetText(i);
	}

	public void SetText(string i)
	{
		if (i == string.Empty)
		{
			i = null;
		}
		if (NetworkServer.active)
		{
			Network_myText = i;
		}
		MyText = i;
		NamedColor namedColor = NamedColors.FirstOrDefault((NamedColor row) => row.Name == MyColor);
		if (namedColor != null)
		{
			CurrentColor = namedColor;
		}
	}

	private void HidePlayerList(bool oldValue, bool newValue)
	{
		if (ReferenceHub.TryGetHub(base.gameObject, out var hub) && hub.authManager.InstanceMode == ClientInstanceMode.Dummy)
		{
			if (newValue)
			{
				PlayerList.DestroyPlayer(hub);
			}
			else
			{
				PlayerList.AddPlayer(hub);
			}
		}
	}

	[Server]
	public bool RefreshGlobalTag()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Boolean ServerRoles::RefreshGlobalTag()' called when server was not active");
			return default;
		}
		if (!HasGlobalBadge)
		{
			return false;
		}
		PlayerChangingBadgeVisibilityEventArgs e = new PlayerChangingBadgeVisibilityEventArgs(_hub, isGlobal: true, newVisibility: false);
		PlayerEvents.OnChangingBadgeVisibility(e);
		if (!e.IsAllowed)
		{
			return false;
		}
		SetColor(null);
		SetText(null);
		NetworkGlobalBadge = _hub.authManager.AuthenticationResponse.SignedBadgeToken.token;
		NetworkGlobalBadgeSignature = _hub.authManager.AuthenticationResponse.SignedBadgeToken.signature;
		HiddenBadge = null;
		GlobalHidden = false;
		RpcResetFixed();
		PlayerEvents.OnChangedBadgeVisibility(new PlayerChangedBadgeVisibilityEventArgs(_hub, isGlobal: true, newVisibility: false));
		return true;
	}

	[Server]
	public void RefreshLocalTag()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerRoles::RefreshLocalTag()' called when server was not active");
			return;
		}
		PlayerChangingBadgeVisibilityEventArgs e = new PlayerChangingBadgeVisibilityEventArgs(_hub, isGlobal: false, newVisibility: false);
		PlayerEvents.OnChangingBadgeVisibility(e);
		if (e.IsAllowed)
		{
			NetworkGlobalBadge = null;
			NetworkGlobalBadgeSignature = null;
			HiddenBadge = null;
			GlobalHidden = false;
			RpcResetFixed();
			RefreshPermissions(disp: true);
			PlayerEvents.OnChangedBadgeVisibility(new PlayerChangedBadgeVisibilityEventArgs(_hub, isGlobal: false, newVisibility: false));
		}
	}

	[Server]
	public bool TryHideTag()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Boolean ServerRoles::TryHideTag()' called when server was not active");
			return default;
		}
		bool isGlobal;
		if (string.IsNullOrEmpty(MyText))
		{
			if (GlobalBadge != null && _hub.authManager.AuthenticationResponse.BadgeToken != null)
			{
				isGlobal = true;
				PlayerChangingBadgeVisibilityEventArgs e = new PlayerChangingBadgeVisibilityEventArgs(_hub, isGlobal, newVisibility: false);
				PlayerEvents.OnChangingBadgeVisibility(e);
				if (!e.IsAllowed)
				{
					return false;
				}
				HiddenBadge = _hub.authManager.AuthenticationResponse.BadgeToken.BadgeText;
				GlobalHidden = true;
			}
			else
			{
				if (!_hub.authManager.BypassBansFlagSet)
				{
					return false;
				}
				isGlobal = false;
				PlayerChangingBadgeVisibilityEventArgs e2 = new PlayerChangingBadgeVisibilityEventArgs(_hub, isGlobal, newVisibility: false);
				PlayerEvents.OnChangingBadgeVisibility(e2);
				if (!e2.IsAllowed)
				{
					return false;
				}
				GlobalHidden = false;
				HiddenBadge = null;
			}
		}
		else
		{
			isGlobal = false;
			PlayerChangingBadgeVisibilityEventArgs e3 = new PlayerChangingBadgeVisibilityEventArgs(_hub, isGlobal, newVisibility: false);
			PlayerEvents.OnChangingBadgeVisibility(e3);
			if (!e3.IsAllowed)
			{
				return false;
			}
			GlobalHidden = GlobalSet;
			HiddenBadge = MyText;
		}
		NetworkGlobalBadge = null;
		SetText(null);
		SetColor(null);
		RefreshHiddenTag();
		PlayerEvents.OnChangedBadgeVisibility(new PlayerChangedBadgeVisibilityEventArgs(_hub, isGlobal, newVisibility: false));
		return true;
	}

	internal void OpenRemoteAdmin()
	{
		TargetSetRemoteAdmin(open: true);
		_hub.queryProcessor.SyncCommandsToClient();
	}

	[TargetRpc]
	private void TargetSetRemoteAdmin(bool open)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteBool(open);
		SendTargetRPCInternal(null, "System.Void ServerRoles::TargetSetRemoteAdmin(System.Boolean)", -586263322, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	static ServerRoles()
	{
		DictionarizedColorsCache = new Dictionary<string, NamedColor>();
		RemoteProcedureCalls.RegisterCommand(typeof(ServerRoles), "System.Void ServerRoles::CmdSetLocalTagPreferences(ServerRoles/BadgePreferences,ServerRoles/BadgeVisibilityPreferences,ServerRoles/BadgeVisibilityPreferences,System.Boolean)", InvokeUserCode_CmdSetLocalTagPreferences__BadgePreferences__BadgeVisibilityPreferences__BadgeVisibilityPreferences__Boolean, requiresAuthority: true);
		RemoteProcedureCalls.RegisterRpc(typeof(ServerRoles), "System.Void ServerRoles::RpcResetFixed()", InvokeUserCode_RpcResetFixed);
		RemoteProcedureCalls.RegisterRpc(typeof(ServerRoles), "System.Void ServerRoles::TargetSetHiddenRole(Mirror.NetworkConnection,System.String)", InvokeUserCode_TargetSetHiddenRole__NetworkConnection__String);
		RemoteProcedureCalls.RegisterRpc(typeof(ServerRoles), "System.Void ServerRoles::TargetSetRemoteAdmin(System.Boolean)", InvokeUserCode_TargetSetRemoteAdmin__Boolean);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_TargetSetHiddenRole__NetworkConnection__String(NetworkConnection connection, string role)
	{
		if (!base.isServer)
		{
			if (string.IsNullOrEmpty(role))
			{
				SetColor(null);
				SetText(null);
				FixedBadge = null;
				SetText(null);
			}
			else
			{
				SetColor("silver");
				FixedBadge = TranslateGlobalBadge(Misc.SanitizeRichText(role.Replace("[", string.Empty).Replace("]", string.Empty)), hidden: true) + " " + TranslationReader.Get("Legacy_Interfaces", 18, "(hidden)");
				SetText(FixedBadge);
			}
		}
	}

	protected static void InvokeUserCode_TargetSetHiddenRole__NetworkConnection__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetSetHiddenRole called on server.");
		}
		else
		{
			((ServerRoles)obj).UserCode_TargetSetHiddenRole__NetworkConnection__String(null, reader.ReadString());
		}
	}

	protected void UserCode_RpcResetFixed()
	{
		FixedBadge = null;
	}

	protected static void InvokeUserCode_RpcResetFixed(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcResetFixed called on server.");
		}
		else
		{
			((ServerRoles)obj).UserCode_RpcResetFixed();
		}
	}

	protected void UserCode_CmdSetLocalTagPreferences__BadgePreferences__BadgeVisibilityPreferences__BadgeVisibilityPreferences__Boolean(BadgePreferences userPreferences, BadgeVisibilityPreferences globalPreferences, BadgeVisibilityPreferences localPreferences, bool refresh)
	{
		UserBadgePreferences = userPreferences;
		_globalBadgeVisibilityPreferences = globalPreferences;
		_localBadgeVisibilityPreferences = localPreferences;
		if (!refresh)
		{
			return;
		}
		if (userPreferences == BadgePreferences.PreferGlobal && HasGlobalBadge)
		{
			RefreshGlobalBadgeVisibility(globalPreferences);
		}
		else if (Group == null)
		{
			if (HasGlobalBadge)
			{
				RefreshGlobalBadgeVisibility(globalPreferences);
			}
		}
		else
		{
			RefreshLocalBadgeVisibility(localPreferences);
		}
	}

	protected static void InvokeUserCode_CmdSetLocalTagPreferences__BadgePreferences__BadgeVisibilityPreferences__BadgeVisibilityPreferences__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkServer.active)
		{
			Debug.LogError("Command CmdSetLocalTagPreferences called on client.");
		}
		else
		{
			((ServerRoles)obj).UserCode_CmdSetLocalTagPreferences__BadgePreferences__BadgeVisibilityPreferences__BadgeVisibilityPreferences__Boolean(GeneratedNetworkCode._Read_ServerRoles_002FBadgePreferences(reader), GeneratedNetworkCode._Read_ServerRoles_002FBadgeVisibilityPreferences(reader), GeneratedNetworkCode._Read_ServerRoles_002FBadgeVisibilityPreferences(reader), reader.ReadBool());
		}
	}

	protected void UserCode_TargetSetRemoteAdmin__Boolean(bool open)
	{
		if (global::RemoteAdmin.RemoteAdminUIController.Singleton != null)
		{
			global::RemoteAdmin.RemoteAdminUIController.Singleton.SetLoggedIn(open);
		}
		else
		{
			global::RemoteAdmin.RemoteAdminUIController.PendingLogin = open;
		}
	}

	protected static void InvokeUserCode_TargetSetRemoteAdmin__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetSetRemoteAdmin called on server.");
		}
		else
		{
			((ServerRoles)obj).UserCode_TargetSetRemoteAdmin__Boolean(reader.ReadBool());
		}
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteString(_myText);
			writer.WriteString(_myColor);
			writer.WriteString(GlobalBadge);
			writer.WriteString(GlobalBadgeSignature);
			writer.WriteBool(HideFromPlayerList);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteString(_myText);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteString(_myColor);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteString(GlobalBadge);
		}
		if ((base.syncVarDirtyBits & 8L) != 0L)
		{
			writer.WriteString(GlobalBadgeSignature);
		}
		if ((base.syncVarDirtyBits & 0x10L) != 0L)
		{
			writer.WriteBool(HideFromPlayerList);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _myText, SetTextHook, reader.ReadString());
			GeneratedSyncVarDeserialize(ref _myColor, SetColorHook, reader.ReadString());
			GeneratedSyncVarDeserialize(ref GlobalBadge, null, reader.ReadString());
			GeneratedSyncVarDeserialize(ref GlobalBadgeSignature, null, reader.ReadString());
			GeneratedSyncVarDeserialize(ref HideFromPlayerList, HidePlayerList, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _myText, SetTextHook, reader.ReadString());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _myColor, SetColorHook, reader.ReadString());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref GlobalBadge, null, reader.ReadString());
		}
		if ((num & 8L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref GlobalBadgeSignature, null, reader.ReadString());
		}
		if ((num & 0x10L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref HideFromPlayerList, HidePlayerList, reader.ReadBool());
		}
	}
}
