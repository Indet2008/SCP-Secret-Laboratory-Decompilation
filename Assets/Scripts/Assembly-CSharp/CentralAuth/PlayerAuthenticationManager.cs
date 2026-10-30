using System;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using Cryptography;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using Mirror.RemoteCalls;
using NetworkManagerUtils.Dummies;
using NorthwoodLib;
using UnityEngine;
using VoiceChat;

namespace CentralAuth
{
	public class PlayerAuthenticationManager : NetworkBehaviour
	{
		[SyncVar(hook = "UserIdHook")]
		public string SyncedUserId;

		public static bool OnlineMode;

		internal static bool AllowSameAccountJoining;

		public static uint AuthenticationTimeout;

		private static readonly Regex _saltRegex;

		internal string RealUserId;

		private bool _authenticationRequested;

		private float _timeoutTimer;

		private float _passwordCooldown;

		private string _privUserId;

		private string _challenge;

		private string _clientSalt;

		private uint _passwordAttempts;

		private ReferenceHub _hub;

		private ClientInstanceMode _targetInstanceMode;

		private const int HashIterations = 1600;

		private const string HostId = "ID_Host";

		private const string DedicatedId = "ID_Dedicated";

		private const string OfflineModeIdPrefix = "ID_Offline_";

		private const string DummyId = "ID_Dummy";

		public AuthenticationResponse AuthenticationResponse { get; private set; }

		public bool DoNotTrack { get; private set; }

		public string UserId
		{
			get
			{
				if (!NetworkServer.active)
				{
					return SyncedUserId;
				}
				if (_privUserId == null)
				{
					return null;
				}
				if (_privUserId.Contains("$"))
				{
					return _privUserId.Substring(0, _privUserId.IndexOf("$", StringComparison.Ordinal));
				}
				return _privUserId;
			}
			set
			{
				if (NetworkServer.active)
				{
					_privUserId = value;
					UserIdHook(null, value);
					RefreshSyncedId();
					_hub.serverRoles.RefreshRealId();
				}
			}
		}

		public string SaltedUserId
		{
			get
			{
				if (!NetworkServer.active)
				{
					return SyncedUserId;
				}
				return _privUserId;
			}
		}

		public ClientInstanceMode InstanceMode
		{
			get
			{
				return _targetInstanceMode;
			}
			private set
			{
				if (value != _targetInstanceMode)
				{
					_targetInstanceMode = value;
					OnInstanceModeChanged?.Invoke(_hub, _targetInstanceMode);
				}
			}
		}

		public bool NorthwoodStaff => AuthenticationResponse.BadgeToken?.Staff ?? false;

		public bool BypassBansFlagSet => AuthenticationResponse.AuthToken?.BypassBans ?? false;

		public bool RemoteAdminGlobalAccess
		{
			get
			{
				BadgeToken badgeToken = AuthenticationResponse.BadgeToken;
				if (badgeToken != null && (badgeToken.Management || badgeToken.GlobalBanning))
				{
					return true;
				}
				return false;
			}
		}

		public string NetworkSyncedUserId
		{
			get
			{
				return SyncedUserId;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SyncedUserId, 1uL, UserIdHook);
			}
		}

		public static event Action<ReferenceHub> OnSyncedUserIdAssigned;

		public static event Action<ReferenceHub, ClientInstanceMode> OnInstanceModeChanged;

		[Server]
		private void RefreshSyncedId()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::RefreshSyncedId()' called when server was not active");
				return;
			}
			if (_privUserId == null)
			{
				NetworkSyncedUserId = null;
				return;
			}
			bool flag = base.isLocalPlayer || _hub.IsDummy || (_privUserId.EndsWith("@steam", StringComparison.Ordinal) && !DoNotTrack && !AuthenticationResponse.AuthToken.SyncHashed);
			NetworkSyncedUserId = (flag ? _privUserId : Sha.HashToString(Sha.Sha512(_privUserId)));
		}

		private void Awake()
		{
			_hub = ReferenceHub.GetHub(this);
		}

		private void FixedUpdate()
		{
			if (_passwordCooldown > 0f)
			{
				_passwordCooldown -= Time.fixedDeltaTime;
			}
			if (InstanceMode == ClientInstanceMode.Unverified && NetworkServer.active && OnlineMode && !base.isLocalPlayer && !(_timeoutTimer < 0f))
			{
				if (!_authenticationRequested && base.connectionToClient.isReady)
				{
					RequestAuthentication();
				}
				_timeoutTimer += Time.fixedDeltaTime;
				if (!(_timeoutTimer <= (float)AuthenticationTimeout))
				{
					_timeoutTimer = -1f;
					RejectAuthentication("authentication timeout exceeded.");
				}
			}
		}

		private void Start()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			if (base.isLocalPlayer)
			{
				NetworkServer.ReplaceHandler<AuthenticationResponse>(ServerReceiveAuthenticationResponse);
			}
			if (base.connectionToClient is DummyNetworkConnection)
			{
				UserId = "ID_Dummy";
			}
			else if (base.isLocalPlayer && ServerStatic.IsDedicated)
			{
				UserId = "ID_Dedicated";
			}
			else if (base.isLocalPlayer)
			{
				UserId = "ID_Host";
				if (OnlineMode)
				{
					RequestAuthentication();
				}
			}
			else if (!OnlineMode)
			{
				UserId = "ID_Offline_" + base.netId + "_" + DateTimeOffset.Now.ToUnixTimeSeconds();
			}
		}

		private static void ServerReceiveAuthenticationResponse(NetworkConnection conn, AuthenticationResponse msg)
		{
			if (NetworkServer.active && OnlineMode && ReferenceHub.TryGetHub(conn, out var hub))
			{
				hub.authManager.ProcessAuthenticationResponse(msg);
			}
		}

		public string GetAuthToken()
		{
			if (AuthenticationResponse.SignedAuthToken != null)
			{
				return JsonSerialize.ToJson(AuthenticationResponse.SignedAuthToken);
			}
			return null;
		}

		[Server]
		private void RequestAuthentication()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::RequestAuthentication()' called when server was not active");
				return;
			}
			if (!base.isLocalPlayer)
			{
				_authenticationRequested = true;
				_hub.encryptedChannelManager.PrepareExchange();
			}
			_challenge = RandomGenerator.GetStringSecure(24);
			RpcRequestAuthentication(_challenge, (_hub.encryptedChannelManager.EcdhKeys == null) ? null : ECDSA.KeyToString(_hub.encryptedChannelManager.EcdhKeys.Public));
		}

		[TargetRpc]
		private void RpcRequestAuthentication(string challenge, string ecdhPublicKey)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteString(challenge);
			writer.WriteString(ecdhPublicKey);
			SendTargetRPCInternal(null, "System.Void CentralAuth.PlayerAuthenticationManager::RpcRequestAuthentication(System.String,System.String)", -1619731460, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[TargetRpc]
		internal void TargetSetRealId(NetworkConnection conn, string userId)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteString(userId);
			SendTargetRPCInternal(conn, "System.Void CentralAuth.PlayerAuthenticationManager::TargetSetRealId(Mirror.NetworkConnection,System.String)", 295172299, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		private void ProcessAuthenticationResponse(AuthenticationResponse msg)
		{
			try
			{
				if (!_authenticationRequested)
				{
					_hub.gameConsoleTransmission.SendToClient("Authentication token was not requested by the server.", "yellow");
					return;
				}
				if (_challenge == null)
				{
					_hub.gameConsoleTransmission.SendToClient("Authentication token has already been sent.", "yellow");
					return;
				}
				AuthenticationResponse = msg;
				AuthenticationToken token;
				string userId;
				string text;
				IPEndPoint iPEndPoint;
				PreauthItem value;
				if (msg.SignedAuthToken != null)
				{
					if ((msg.EcdhPublicKey == null || msg.EcdhPublicKeySignature == null) && !base.isLocalPlayer)
					{
						RejectAuthentication("null ECDH public key or public key signature.");
						return;
					}
					if (msg.SignedAuthToken.TryGetToken<AuthenticationToken>("Authentication", out token, out var error, out userId))
					{
						text = RemoveSalt(token.UserId);
						if (_challenge != token.Challenge)
						{
							RejectAuthentication("invalid authentication challenge.", userId);
							return;
						}
						_challenge = null;
						if (token.PublicKey != msg.PublicKeyHash)
						{
							RejectAuthentication("public key hash mismatch.", userId);
							return;
						}
						if (GameCore.Version.PrivateBeta && !token.PrivateBetaOwnership)
						{
							RejectAuthentication("you don't own the Private Beta Access Pass DLC.", userId);
							return;
						}
						if (token.PlayerId != _hub.PlayerId)
						{
							RejectAuthentication($"PlayerID Mismatch.\nYour ID: {_hub.PlayerId}\nAuth ID: {token.PlayerId}", userId);
							return;
						}
						if (token.GameVersion != null)
						{
							System.Version version = System.Version.Parse(token.GameVersion);
							System.Version version2 = System.Version.Parse($"{GameCore.Version.Major}.{GameCore.Version.Minor}.{GameCore.Version.Revision}");
							if (version2 > version)
							{
								RejectAuthentication($"Version mismatch\nAuthentication token is only valid until version: {version}\nGame server version: {version2}", userId);
								return;
							}
						}
						iPEndPoint = null;
						if (!base.isLocalPlayer)
						{
							iPEndPoint = LiteNetLib4MirrorServer.Peers[base.connectionToClient.connectionId].EndPoint;
							if (iPEndPoint != null)
							{
								if (CustomLiteNetLib4MirrorTransport.UserIds.ContainsKey(iPEndPoint))
								{
									value = CustomLiteNetLib4MirrorTransport.UserIds[iPEndPoint];
									if (value.UserId.Equals(text, StringComparison.Ordinal))
									{
										goto IL_02cc;
									}
								}
								if (!CustomLiteNetLib4MirrorTransport.UserIdFastReload.ContainsKey(text))
								{
									_hub.gameConsoleTransmission.SendToClient("UserID mismatch between authentication and preauthentication token.", "red");
									_hub.gameConsoleTransmission.SendToClient("Preauth: " + (CustomLiteNetLib4MirrorTransport.UserIds.TryGetValue(iPEndPoint, out var value2) ? value2.UserId : "(null)"), "red");
									_hub.gameConsoleTransmission.SendToClient("Auth: " + text, "red");
									RejectAuthentication("UserID mismatch between authentication and preauthentication token. Check the game console for more details.", text);
									return;
								}
							}
							goto IL_02cc;
						}
						goto IL_02df;
					}
					RejectAuthentication(error, userId, removeSalt: true);
					return;
				}
				RejectAuthentication("authentication token not provided.");
				return;
				IL_02df:
				if (CustomLiteNetLib4MirrorTransport.UserIdFastReload.ContainsKey(text))
				{
					CustomLiteNetLib4MirrorTransport.UserIdFastReload.TryRemove(text, out var _);
				}
				if (msg.EcdhPublicKey != null && !ECDSA.VerifyBytes(msg.EcdhPublicKey, msg.EcdhPublicKeySignature, msg.PublicKey))
				{
					RejectAuthentication("invalid ECDH exchange public key signature.", userId);
				}
				else
				{
					if (!CheckBans(token, text))
					{
						return;
					}
					if (msg.EcdhPublicKey != null)
					{
						_hub.encryptedChannelManager.ServerProcessExchange(msg.EcdhPublicKey);
					}
					msg.AuthToken = token;
					AuthenticationResponse = msg;
					string text2 = string.Format("{0} authenticated from endpoint {1}. Player ID assigned: {2}. Auth token serial number: {3}.", RemoveSalt(msg.AuthToken.UserId), (iPEndPoint == null) ? "(null)" : iPEndPoint.ToString(), _hub.PlayerId, msg.AuthToken.Serial);
					ServerConsole.AddLog(text2);
					ServerLogs.AddLog(ServerLogs.Modules.Networking, text2, ServerLogs.ServerLogType.ConnectionUpdate);
					FinalizeAuthentication();
					if (msg.SignedBadgeToken != null)
					{
						if (msg.SignedBadgeToken.TryGetToken<BadgeToken>("Badge request", out var token2, out var error2, out var _))
						{
							if (token2.Serial != AuthenticationResponse.AuthToken.Serial)
							{
								RejectAuthentication("token serial number mismatch.");
								return;
							}
							if (token2.UserId != Sha.HashToString(Sha.Sha512(SaltedUserId)))
							{
								RejectBadgeToken("badge token UserID mismatch.");
								return;
							}
							if (StringUtils.Base64Decode(token2.Nickname) != _hub.nicknameSync.MyNick)
							{
								RejectBadgeToken("badge token nickname mismatch.");
								return;
							}
							msg.BadgeToken = token2;
							AuthenticationResponse = msg;
							ulong num = ((token2.RaPermissions == 0L || ServerStatic.PermissionsHandler.NorthwoodAccess) ? ServerStatic.PermissionsHandler.FullPerm : token2.RaPermissions);
							if ((token2.Management || token2.GlobalBanning) && CustomNetworkManager.IsVerified)
							{
								_hub.serverRoles.GlobalPerms |= 8388608uL;
								_hub.serverRoles.GlobalPerms |= 1048576uL;
							}
							if (AuthenticationResponse.BadgeToken.OverwatchMode)
							{
								_hub.serverRoles.GlobalPerms |= 4096uL;
							}
							if (token2.Staff || token2.Management || token2.GlobalBanning)
							{
								_hub.serverRoles.GlobalPerms |= 16908288uL;
							}
							if ((token2.Staff && ServerStatic.PermissionsHandler.NorthwoodAccess) || (token2.RemoteAdmin && ServerStatic.PermissionsHandler.StaffAccess) || (token2.Management && ServerStatic.PermissionsHandler.ManagersAccess) || (token2.GlobalBanning && ServerStatic.PermissionsHandler.BanningTeamAccess))
							{
								_hub.serverRoles.GlobalPerms |= num;
							}
							if ((token2.BadgeText != null && token2.BadgeText != "(none)") || (token2.BadgeColor != null && token2.BadgeColor != "(none)"))
							{
								if (_hub.serverRoles.UserBadgePreferences == ServerRoles.BadgePreferences.PreferGlobal || !_hub.serverRoles.BadgeCover || _hub.serverRoles.Group == null)
								{
									bool flag = msg.HideBadge;
									switch (token2.BadgeType)
									{
									case 1:
										if (!ConfigFile.ServerConfig.GetBool("hide_staff_badges_by_default"))
										{
											break;
										}
										goto case 3;
									case 2:
										if (!ConfigFile.ServerConfig.GetBool("hide_management_badges_by_default"))
										{
											break;
										}
										goto case 3;
									case 0:
										if (!ConfigFile.ServerConfig.GetBool("hide_patreon_badges_by_default") || CustomNetworkManager.IsVerified)
										{
											break;
										}
										goto case 3;
									case 3:
										flag = true;
										break;
									}
									if (flag)
									{
										_hub.serverRoles.HiddenBadge = token2.BadgeText;
										_hub.serverRoles.GlobalHidden = true;
										_hub.serverRoles.RefreshHiddenTag();
										_hub.gameConsoleTransmission.SendToClient("Your global badge has been granted, but it's hidden. Use \".gtag\" command in the game console to show your global badge.", "yellow");
									}
									else
									{
										_hub.serverRoles.HiddenBadge = null;
										_hub.serverRoles.RpcResetFixed();
										_hub.serverRoles.NetworkGlobalBadge = AuthenticationResponse.SignedBadgeToken.token;
										_hub.serverRoles.NetworkGlobalBadgeSignature = AuthenticationResponse.SignedBadgeToken.signature;
										_hub.gameConsoleTransmission.SendToClient("Your global badge has been granted.", "cyan");
									}
								}
								else
								{
									_hub.gameConsoleTransmission.SendToClient("Your global badge is covered by server badge. Use \".gtag\" command in the game console to show your global badge.", "yellow");
								}
							}
							_hub.serverRoles.FinalizeSetGroup();
						}
						else
						{
							RejectBadgeToken(error2);
						}
					}
					PlayerEvents.OnJoined(new PlayerJoinedEventArgs(_hub));
				}
				return;
				IL_02cc:
				if (iPEndPoint != null)
				{
					CustomLiteNetLib4MirrorTransport.UserIds.TryRemove(iPEndPoint, out value);
				}
				goto IL_02df;
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Exception during authentication (client address: " + base.connectionToClient.address + "): " + ex.Message, ConsoleColor.Magenta);
				ServerConsole.AddLog(ex.StackTrace, ConsoleColor.Magenta);
				RejectAuthentication("server exception during authentication!");
			}
		}

		[Server]
		private void RejectAuthentication(string reason, string userId = null, bool removeSalt = false)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::RejectAuthentication(System.String,System.String,System.Boolean)' called when server was not active");
				return;
			}
			if ((userId != null) & removeSalt)
			{
				userId = RemoveSalt(userId);
			}
			ServerConsole.AddLog("Player " + (userId ?? "(unknown)") + " (" + base.connectionToClient.address + ") failed to authenticate: " + reason);
			_hub.gameConsoleTransmission.SendToClient("Authentication failure: " + reason, "red");
			ServerConsole.Disconnect(_hub.connectionToClient, "Authentication failure: " + reason);
		}

		[Server]
		private void RejectBadgeToken(string reason)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::RejectBadgeToken(System.String)' called when server was not active");
			}
			else
			{
				_hub.gameConsoleTransmission.SendToClient("Your global badge token is invalid. Reason: " + reason, "red");
			}
		}

		[Server]
		private void FinalizeAuthentication()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::FinalizeAuthentication()' called when server was not active");
				return;
			}
			UserId = AuthenticationResponse.AuthToken.UserId;
			DoNotTrack = AuthenticationResponse.DoNotTrack || AuthenticationResponse.AuthToken.DoNotTrack;
			_hub.nicknameSync.UpdateNickname(StringUtils.Base64Decode(AuthenticationResponse.AuthToken.Nickname));
			if (DoNotTrack)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Networking, _hub.LoggedNameFromRefHub() + " connected from IP address " + base.connectionToClient.address + " sent Do Not Track signal.", ServerLogs.ServerLogType.ConnectionUpdate);
			}
			_hub.gameConsoleTransmission.SendToClient("Hi " + _hub.nicknameSync.MyNick + "! You have been authenticated on this server.", "green");
			_hub.serverRoles.RefreshPermissions();
			if (AllowSameAccountJoining)
			{
				return;
			}
			int playerId = ReferenceHub.GetHub(base.gameObject).PlayerId;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.authManager.UserId == UserId && allHub.PlayerId != playerId && !allHub.isLocalPlayer)
				{
					ServerConsole.AddLog($"Player {UserId} ({allHub.PlayerId}, {base.connectionToClient.address}) has been kicked from the server, because he has just joined the server again from IP address {base.connectionToClient.address}.");
					ServerConsole.Disconnect(allHub.gameObject, "Only one player instance of the same player is allowed.");
				}
			}
		}

		[Server]
		private bool CheckBans(AuthenticationToken token, string unsalted)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Boolean CentralAuth.PlayerAuthenticationManager::CheckBans(AuthenticationToken,System.String)' called when server was not active");
				return default;
			}
			if ((!token.BypassBans || !CustomNetworkManager.IsVerified) && BanHandler.QueryBan(unsalted, null).Key != null)
			{
				_hub.gameConsoleTransmission.SendToClient("You are banned from this server.", "red");
				ServerConsole.AddLog("Player kicked due to local UserID ban.");
				ServerConsole.Disconnect(_hub.connectionToClient, "You are banned from this server.");
				return false;
			}
			if (CustomNetworkManager.IsVerified || CustomLiteNetLib4MirrorTransport.UseGlobalBans)
			{
				switch (token.GlobalBan)
				{
				case "M1":
					ServerConsole.AddLog("Player " + token.UserId + " is globally muted.");
					break;
				case "M2":
					ServerConsole.AddLog("Player " + token.UserId + " is globally muted on intercom.");
					break;
				default:
					_hub.gameConsoleTransmission.SendToClient(token.GlobalBan, "red");
					ServerConsole.AddLog("Player " + token.UserId + " has been kicked due to an active global ban: " + token.GlobalBan);
					ServerConsole.Disconnect(_hub.connectionToClient, token.GlobalBan);
					return false;
				case "NO":
					break;
				}
			}
			if (!token.SkipIpCheck && !token.RequestIp.Equals("N/A", StringComparison.Ordinal) && ServerConsole.EnforceSameIp)
			{
				string address = _hub.connectionToClient.address;
				if ((address.Contains(".", StringComparison.Ordinal) && token.RequestIp.Contains(".", StringComparison.Ordinal)) || (address.Contains(":", StringComparison.Ordinal) && token.RequestIp.Contains(":", StringComparison.Ordinal)))
				{
					bool flag = false;
					if (ServerConsole.SkipEnforcementForLocalAddresses)
					{
						flag = address == "127.0.0.1" || address.StartsWith("10.", StringComparison.Ordinal) || address.StartsWith("192.168.", StringComparison.Ordinal);
						if (!flag && address.StartsWith("172.", StringComparison.Ordinal))
						{
							string[] array = address.Split('.');
							if (array.Length == 4 && byte.TryParse(array[1], out var result) && result >= 16 && result <= 31)
							{
								flag = true;
							}
						}
					}
					if (!flag && address != token.RequestIp)
					{
						_hub.gameConsoleTransmission.SendToClient("Authentication token has been issued to a different IP address.", "red");
						_hub.gameConsoleTransmission.SendToClient("Your IP address: " + address, "red");
						_hub.gameConsoleTransmission.SendToClient("Issued to: " + token.RequestIp, "red");
						ServerConsole.AddLog("Player kicked due to IP addresses mismatch.");
						ServerConsole.Disconnect(_hub.connectionToClient, "Authentication token has been issued to a different IP address. You can find details in the game console.");
						return false;
					}
				}
			}
			VcMuteFlags vcMuteFlags = VcMuteFlags.None;
			if (VoiceChatMutes.QueryLocalMute(unsalted))
			{
				vcMuteFlags |= VcMuteFlags.LocalRegular;
				_hub.gameConsoleTransmission.SendToClient("You are muted on the voice chat by the server administrator.", "red");
			}
			if ((ConfigFile.ServerConfig.GetBool("global_mutes_voicechat", def: true) || CustomNetworkManager.IsVerified) && token.GlobalBan == "M1")
			{
				vcMuteFlags |= VcMuteFlags.GlobalRegular;
				_hub.gameConsoleTransmission.SendToClient("You are globally muted on the voice chat.", "red");
			}
			if (VoiceChatMutes.QueryLocalMute(unsalted, intercom: true))
			{
				vcMuteFlags |= VcMuteFlags.LocalIntercom;
				_hub.gameConsoleTransmission.SendToClient("You are muted on the intercom by the server administrator.", "red");
			}
			else if ((ConfigFile.ServerConfig.GetBool("global_mutes_intercom", def: true) || CustomNetworkManager.IsVerified) && token.GlobalBan == "M2")
			{
				vcMuteFlags |= VcMuteFlags.GlobalIntercom;
				_hub.gameConsoleTransmission.SendToClient("You are globally muted on the intercom.", "red");
			}
			if (token.BypassBans)
			{
				vcMuteFlags = VcMuteFlags.None;
			}
			VoiceChatMutes.SetFlags(_hub, vcMuteFlags);
			return true;
		}

		private static string RemoveSalt(string userId)
		{
			if (userId != null)
			{
				if (userId.Contains("$"))
				{
					return userId.Substring(0, userId.IndexOf("$", StringComparison.Ordinal));
				}
				return userId;
			}
			return null;
		}

		[Command]
		private void CmdHandlePasswordAuthentication(string clientSalt, byte[] signature, string ecdhPublicKey)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteString(clientSalt);
			writer.WriteBytesAndSize(signature);
			writer.WriteString(ecdhPublicKey);
			SendCommandInternal("System.Void CentralAuth.PlayerAuthenticationManager::CmdHandlePasswordAuthentication(System.String,System.Byte[],System.String)", 1988415082, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[TargetRpc]
		private void RpcFinishExchange(string publicKey, byte[] signature)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteString(publicKey);
			writer.WriteBytesAndSize(signature);
			SendTargetRPCInternal(null, "System.Void CentralAuth.PlayerAuthenticationManager::RpcFinishExchange(System.String,System.Byte[])", 112993832, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[TargetRpc]
		private void RpcAnimateInvalidPassword()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendTargetRPCInternal(null, "System.Void CentralAuth.PlayerAuthenticationManager::RpcAnimateInvalidPassword()", 2027815992, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[Server]
		public void ResetPasswordAttempts()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::ResetPasswordAttempts()' called when server was not active");
			}
			else
			{
				_passwordAttempts = 0u;
			}
		}

		[Server]
		private void AssignPasswordOverrideGroup()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CentralAuth.PlayerAuthenticationManager::AssignPasswordOverrideGroup()' called when server was not active");
				return;
			}
			UserGroup overrideGroup = ServerStatic.PermissionsHandler.OverrideGroup;
			if (overrideGroup != null)
			{
				string text = _hub.LoggedNameFromRefHub() + " used a valid RemoteAdmin override password.";
				ServerConsole.AddLog(text, ConsoleColor.DarkYellow);
				ServerLogs.AddLog(ServerLogs.Modules.Permissions, text, ServerLogs.ServerLogType.ConnectionUpdate);
				_hub.serverRoles.SetGroup(overrideGroup, byAdmin: true);
			}
			else
			{
				ServerConsole.AddLog("Non-existing group is assigned for override password!", ConsoleColor.Red);
				_hub.gameConsoleTransmission.SendToClient("Non-existing group is assigned for override password!", "red");
			}
		}

		private static byte[] DerivePassword(string password, string serversalt, string clientsalt)
		{
			byte[] salt = Sha.Sha512(serversalt + "/" + clientsalt);
			return PBKDF2.Pbkdf2HashBytes(password, salt, 1600, 512);
		}

		private void UserIdHook(string p, string i)
		{
			OnSyncedUserIdAssigned?.Invoke(_hub);
			if (string.IsNullOrEmpty(i))
			{
				InstanceMode = ClientInstanceMode.Unverified;
				return;
			}
			InstanceMode = i switch
			{
				"ID_Dedicated" => ClientInstanceMode.DedicatedServer, 
				"ID_Host" => ClientInstanceMode.Host, 
				"ID_Dummy" => ClientInstanceMode.Dummy, 
				_ => ClientInstanceMode.ReadyClient, 
			};
		}

		static PlayerAuthenticationManager()
		{
			_saltRegex = new Regex("^[a-zA-Z0-9]{32}$", RegexOptions.Compiled);
			RemoteProcedureCalls.RegisterCommand(typeof(PlayerAuthenticationManager), "System.Void CentralAuth.PlayerAuthenticationManager::CmdHandlePasswordAuthentication(System.String,System.Byte[],System.String)", InvokeUserCode_CmdHandlePasswordAuthentication__String__Byte_005B_005D__String, requiresAuthority: true);
			RemoteProcedureCalls.RegisterRpc(typeof(PlayerAuthenticationManager), "System.Void CentralAuth.PlayerAuthenticationManager::RpcRequestAuthentication(System.String,System.String)", InvokeUserCode_RpcRequestAuthentication__String__String);
			RemoteProcedureCalls.RegisterRpc(typeof(PlayerAuthenticationManager), "System.Void CentralAuth.PlayerAuthenticationManager::TargetSetRealId(Mirror.NetworkConnection,System.String)", InvokeUserCode_TargetSetRealId__NetworkConnection__String);
			RemoteProcedureCalls.RegisterRpc(typeof(PlayerAuthenticationManager), "System.Void CentralAuth.PlayerAuthenticationManager::RpcFinishExchange(System.String,System.Byte[])", InvokeUserCode_RpcFinishExchange__String__Byte_005B_005D);
			RemoteProcedureCalls.RegisterRpc(typeof(PlayerAuthenticationManager), "System.Void CentralAuth.PlayerAuthenticationManager::RpcAnimateInvalidPassword()", InvokeUserCode_RpcAnimateInvalidPassword);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcRequestAuthentication__String__String(string challenge, string ecdhPublicKey)
		{
			if (_authenticationRequested)
			{
				GameCore.Console.AddLog("Received a duplicated authentication request from the Game Server.", new Color(1f, 0f, 1f, 1f));
				return;
			}
			_authenticationRequested = true;
			GameCore.Console.AddLog("Received authentication request from the Game Server.", new Color(0.5f, 0.5f, 0.5f, 1f));
			CentralAuthManager.TokenChallenge = challenge;
			CentralAuthManager.ServerEcdhPublicKey = ecdhPublicKey;
			CentralAuthManager.CurrentPlayerId = _hub.PlayerId;
			CentralAuthManager.RequestAuthToken = true;
		}

		protected static void InvokeUserCode_RpcRequestAuthentication__String__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("TargetRPC RpcRequestAuthentication called on server.");
			}
			else
			{
				((PlayerAuthenticationManager)obj).UserCode_RpcRequestAuthentication__String__String(reader.ReadString(), reader.ReadString());
			}
		}

		protected void UserCode_TargetSetRealId__NetworkConnection__String(NetworkConnection conn, string userId)
		{
			RealUserId = userId;
			PlayerList.RefreshPlayerId(base.gameObject);
		}

		protected static void InvokeUserCode_TargetSetRealId__NetworkConnection__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("TargetRPC TargetSetRealId called on server.");
			}
			else
			{
				((PlayerAuthenticationManager)obj).UserCode_TargetSetRealId__NetworkConnection__String(null, reader.ReadString());
			}
		}

		protected void UserCode_CmdHandlePasswordAuthentication__String__Byte_005B_005D__String(string clientSalt, byte[] signature, string ecdhPublicKey)
		{
			if (_passwordAttempts > 2)
			{
				_hub.gameConsoleTransmission.SendToClient("Limit of RA password auth attempts exceeded.", "red");
				return;
			}
			if (_passwordCooldown > 0f)
			{
				_hub.gameConsoleTransmission.SendToClient("Please wait before trying to use password again!", "red");
				return;
			}
			_passwordCooldown = 1.8f;
			if (base.isLocalPlayer)
			{
				_hub.gameConsoleTransmission.SendToClient("Password authentication is not available for the host.", "red");
				return;
			}
			ReferenceHub hostHub = ReferenceHub.HostHub;
			if (!hostHub.queryProcessor.OverridePasswordEnabled)
			{
				_hub.gameConsoleTransmission.SendToClient("Password authentication is disabled on this server!", "red");
				return;
			}
			if (clientSalt == null || signature == null)
			{
				_hub.gameConsoleTransmission.SendToClient("Invalid password auth request - null parameters.", "red");
				return;
			}
			if (!_saltRegex.IsMatch(clientSalt))
			{
				_hub.gameConsoleTransmission.SendToClient("Invalid password auth request - invalid client salt.", "red");
				return;
			}
			byte[] key = DerivePassword(ServerStatic.PermissionsHandler.OverridePassword, hostHub.encryptedChannelManager.ServerRandom, clientSalt);
			if (OnlineMode)
			{
				if (SyncedUserId == null)
				{
					_hub.gameConsoleTransmission.SendToClient("Can't process password auth request - not authenticated while server is in online mode.", "red");
				}
				else if (!Sha.Sha512Hmac(key, SyncedUserId).SequenceEqual(signature))
				{
					_passwordAttempts++;
					string text = _hub.LoggedNameFromRefHub() + " attempted to use an invalid RemoteAdmin override password.";
					ServerConsole.AddLog(text, ConsoleColor.Magenta);
					ServerLogs.AddLog(ServerLogs.Modules.Permissions, text, ServerLogs.ServerLogType.ConnectionUpdate);
					RpcAnimateInvalidPassword();
				}
				else
				{
					AssignPasswordOverrideGroup();
				}
			}
			else if (ecdhPublicKey == null)
			{
				_hub.gameConsoleTransmission.SendToClient("Can't process password auth request - ecdhPublicKey is null in offline mode.", "red");
			}
			else if (!Sha.Sha512Hmac(key, ecdhPublicKey).SequenceEqual(signature))
			{
				_passwordAttempts++;
				string text2 = _hub.LoggedNameFromRefHub() + " attempted to use an invalid RemoteAdmin override password.";
				ServerConsole.AddLog(text2, ConsoleColor.Magenta);
				ServerLogs.AddLog(ServerLogs.Modules.Permissions, text2, ServerLogs.ServerLogType.ConnectionUpdate);
				RpcAnimateInvalidPassword();
			}
			else
			{
				_hub.encryptedChannelManager.PrepareExchange();
				_hub.encryptedChannelManager.ServerProcessExchange(ecdhPublicKey);
				string text3 = ECDSA.KeyToString(_hub.encryptedChannelManager.EcdhKeys.Public);
				byte[] signature2 = Sha.Sha512Hmac(key, text3);
				RpcFinishExchange(text3, signature2);
				AssignPasswordOverrideGroup();
			}
		}

		protected static void InvokeUserCode_CmdHandlePasswordAuthentication__String__Byte_005B_005D__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkServer.active)
			{
				Debug.LogError("Command CmdHandlePasswordAuthentication called on client.");
			}
			else
			{
				((PlayerAuthenticationManager)obj).UserCode_CmdHandlePasswordAuthentication__String__Byte_005B_005D__String(reader.ReadString(), reader.ReadBytesAndSize(), reader.ReadString());
			}
		}

		protected void UserCode_RpcFinishExchange__String__Byte_005B_005D(string publicKey, byte[] signature)
		{
		}

		protected static void InvokeUserCode_RpcFinishExchange__String__Byte_005B_005D(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("TargetRPC RpcFinishExchange called on server.");
			}
			else
			{
				((PlayerAuthenticationManager)obj).UserCode_RpcFinishExchange__String__Byte_005B_005D(reader.ReadString(), reader.ReadBytesAndSize());
			}
		}

		protected void UserCode_RpcAnimateInvalidPassword()
		{
			global::RemoteAdmin.RemoteAdminUIController.Singleton.PlayInvalidPasswordAnimation();
		}

		protected static void InvokeUserCode_RpcAnimateInvalidPassword(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("TargetRPC RpcAnimateInvalidPassword called on server.");
			}
			else
			{
				((PlayerAuthenticationManager)obj).UserCode_RpcAnimateInvalidPassword();
			}
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteString(SyncedUserId);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteString(SyncedUserId);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref SyncedUserId, UserIdHook, reader.ReadString());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SyncedUserId, UserIdHook, reader.ReadString());
			}
		}
	}
}
