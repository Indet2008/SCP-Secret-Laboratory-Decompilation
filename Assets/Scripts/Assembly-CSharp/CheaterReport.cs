using System;
using System.Collections.Generic;
using System.Threading;
using CentralAuth;
using Cryptography;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using NorthwoodLib;
using Security;
using UnityEngine;
using Utf8Json;

public class CheaterReport : NetworkBehaviour
{
	private static readonly Dictionary<char, string> CharacterReplacements;

	internal static bool SendReportsByWebhooks;

	internal static string WebhookUrl;

	internal static string WebhookUsername;

	internal static string WebhookAvatar;

	internal static string ServerName;

	internal static string ReportHeader;

	internal static string ReportContent;

	internal static int WebhookColor;

	private int _reportedPlayersAmount;

	private float _lastReport;

	private HashSet<uint> _reportedPlayers;

	private RateLimit _commandRateLimit;

	private ReferenceHub _hub;

	private void Start()
	{
		_hub = ReferenceHub.GetHub(this);
		_commandRateLimit = _hub.playerRateLimitHandler.RateLimits[1];
	}

	internal void Report(uint playerNetId, string reason, bool notifyGm)
	{
		if (!ReferenceHub.TryGetHubNetID(playerNetId, out var hub))
		{
			GameCore.Console.AddLog("[REPORTING] Can't find player with that PlayerID.", Color.red, nospace: true);
			return;
		}
		byte[] signature = (notifyGm ? ECDSA.SignBytes(hub.authManager.SyncedUserId + ";" + ConvertToLatin(reason), CentralAuth.CentralAuthManager.SessionKeys.Private) : null);
		CmdReport(playerNetId, reason, signature, notifyGm);
	}

	[Command(channel = 4)]
	private void CmdReport(uint playerNetId, string reason, byte[] signature, bool notifyGm)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteUInt(playerNetId);
		writer.WriteString(reason);
		writer.WriteBytesAndSize(signature);
		writer.WriteBool(notifyGm);
		SendCommandInternal("System.Void CheaterReport::CmdReport(System.UInt32,System.String,System.Byte[],System.Boolean)", -1325630461, writer, 4);
		NetworkWriterPool.Return(writer);
	}

	[Server]
	private void IssueReport(GameConsoleTransmission reporter, string reporterUserId, string reportedUserId, string reportedAuth, string reportedIp, string reporterAuth, string reporterIp, ref string reason, ref byte[] signature, string reporterPublicKey, uint reportedNetId, string reporterNickname, string reportedNickname)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void CheaterReport::IssueReport(GameConsoleTransmission,System.String,System.String,System.String,System.String,System.String,System.String,System.String&,System.Byte[]&,System.String,System.UInt32,System.String,System.String)' called when server was not active");
			return;
		}
		try
		{
			string data = $"reporterAuth={StringUtils.Base64Encode(reporterAuth)}&reporterIp={reporterIp}&reportedAuth={StringUtils.Base64Encode(reportedAuth)}&reportedIp={reportedIp}&reason={StringUtils.Base64Encode(ConvertToLatin(reason))}&signature={Convert.ToBase64String(signature)}&reporterKey={StringUtils.Base64Encode(reporterPublicKey)}&token={ServerConsole.Password}&port={ServerConsole.PortToReport}&serverIp={ServerConsole.Ip}";
			string text = HttpQuery.Post(CentralServer.StandardUrl + "ingamereport.php", data, "application/x-www-form-urlencoded");
			if (reporter == null)
			{
				return;
			}
			switch (text)
			{
			case "OK":
				_reportedPlayers.Add(reportedNetId);
				SendSafeConsoleMessage(reporter, "[REPORTING] Player report successfully sent.", "green");
				break;
			case "ReportedUserIDAlreadyReported":
				SendSafeConsoleMessage(reporter, "[REPORTING] A report for this User ID already exists!" + Environment.NewLine, "yellow");
				break;
			case "RateLimited":
				SendSafeConsoleMessage(reporter, "[REPORTING] You are Ratelimited! Try again tomorrow." + Environment.NewLine, "red");
				break;
			default:
				SendSafeConsoleMessage(reporter, "[REPORTING] Error during **PROCESSING** player report:" + Environment.NewLine + text, "red");
				break;
			}
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog("[HOST] Error during **SENDING** player report:" + Environment.NewLine + ex.Message, Color.red);
			if (reporter == null)
			{
				return;
			}
			SendSafeConsoleMessage(reporter, "[REPORTING] Error during **SENDING** player report.", "yellow");
		}
		if (SendReportsByWebhooks)
		{
			LogReport(reporter, reporterUserId, reportedUserId, ref reason, reportedNetId, notifyGm: true, reporterNickname, reportedNickname);
		}
	}

	[Server]
	private void LogReport(GameConsoleTransmission reporter, string reporterUserId, string reportedUserId, ref string reason, uint reportedNetId, bool notifyGm, string reporterNickname, string reportedNickname)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void CheaterReport::LogReport(GameConsoleTransmission,System.String,System.String,System.String&,System.UInt32,System.Boolean,System.String,System.String)' called when server was not active");
		}
		else if (SubmitReport(reporterUserId, reportedUserId, reason, reportedNetId, reporterNickname, reportedNickname, friendlyFire: false))
		{
			if (!notifyGm)
			{
				_reportedPlayers.Add(reportedNetId);
				SendSafeConsoleMessage(reporter, "[REPORTING] Player report successfully sent to local administrators by webhooks.", "green");
			}
		}
		else
		{
			SendSafeConsoleMessage(reporter, "[REPORTING] Failed to send report to local administrators by webhooks.", "red");
		}
	}

	[Server]
	private void SendSafeConsoleMessage(GameConsoleTransmission player, string message, string color)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void CheaterReport::SendSafeConsoleMessage(GameConsoleTransmission,System.String,System.String)' called when server was not active");
			return;
		}
		MainThreadDispatcher.Dispatch(() =>
		{
			player.SendToClient(message, color);
		});
	}

	[Server]
	private void SendStaffChatNotification(string reporterUserId, string reportedUserId, string reason, string reporterNickname, string reportedNickname)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void CheaterReport::SendStaffChatNotification(System.String,System.String,System.String,System.String,System.String)' called when server was not active");
			return;
		}
		string content = "0!<align=center><color=red><u>REPORT RECEIVED</u></color></align>\n<color=yellow>Reporter:</color>\n" + reporterNickname + " (" + reporterUserId + ")\n<color=yellow>Reported:</color>\n" + reportedNickname + " (" + reportedUserId + ")\n<color=yellow>Reason:</color>\n" + reason;
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			ClientInstanceMode mode = allHub.Mode;
			if (mode != ClientInstanceMode.Unverified && mode != ClientInstanceMode.DedicatedServer && allHub.serverRoles.AdminChatPerms)
			{
				allHub.encryptedChannelManager.TrySendMessageToClient(content, EncryptedChannelManager.EncryptedChannel.AdminChat);
			}
		}
	}

	internal static bool SubmitReport(string reporterUserId, string reportedUserId, string reason, uint reportedId, string reporterNickname, string reportedNickname, bool friendlyFire)
	{
		try
		{
			HttpQuery.Post(friendlyFire ? FriendlyFireConfig.WebhookUrl : WebhookUrl, JsonSerializer.ToJsonString(new DiscordWebhook(string.Empty, WebhookUsername, WebhookAvatar, tts: false, new DiscordEmbed[1]
			{
				new DiscordEmbed(ReportHeader, "rich", ReportContent, WebhookColor, new DiscordEmbedField[10]
				{
					new DiscordEmbedField("Server Name", ServerName, inline: false),
					new DiscordEmbedField("Server Endpoint", $"{ServerConsole.Ip}:{ServerConsole.PortToReport}", inline: false),
					new DiscordEmbedField("Reporter UserID", AsDiscordCode(reporterUserId), inline: false),
					new DiscordEmbedField("Reporter Nickname", DiscordSanitize(reporterNickname), inline: false),
					new DiscordEmbedField("Reported UserID", AsDiscordCode(reportedUserId), inline: false),
					new DiscordEmbedField("Reported Nickname", DiscordSanitize(reportedNickname), inline: false),
					new DiscordEmbedField("Reported NetID", reportedId.ToString(), inline: false),
					new DiscordEmbedField("Reason", DiscordSanitize(reason), inline: false),
					new DiscordEmbedField("Timestamp", TimeBehaviour.Rfc3339Time(), inline: false),
					new DiscordEmbedField("UTC Timestamp", TimeBehaviour.Rfc3339Time(DateTimeOffset.UtcNow), inline: false)
				})
			})), "application/json");
			return true;
		}
		catch (Exception ex)
		{
			ServerConsole.AddLog("Failed to send report by webhook: " + ex.Message);
			Debug.LogException(ex);
			return false;
		}
	}

	private static string ConvertToLatin(string str)
	{
		foreach (KeyValuePair<char, string> characterReplacement in CharacterReplacements)
		{
			str = str.Replace(characterReplacement.Key.ToString(), characterReplacement.Value);
		}
		return str;
	}

	private static string AsDiscordCode(string text)
	{
		return "`" + text.Replace("`", "'") + "`";
	}

	private static string DiscordSanitize(string text)
	{
		return text.Replace("<", "(").Replace(">", ")").Replace("@", "@ ")
			.Replace("`", "'")
			.Replace("~~", "∼∼")
			.Replace("*", "★")
			.Replace("_", "\uff3f")
			.Replace("&", " [AMP] ")
			.Replace("?", " [QM] ");
	}

	static CheaterReport()
	{
		CharacterReplacements = new Dictionary<char, string>
		{
			{ 'а', "a" },
			{ 'б', "b" },
			{ 'в', "v" },
			{ 'г', "g" },
			{ 'д', "d" },
			{ 'е', "e" },
			{ 'ё', "yo" },
			{ 'ж', "zh" },
			{ 'з', "z" },
			{ 'и', "i" },
			{ 'й', "j" },
			{ 'к', "k" },
			{ 'л', "l" },
			{ 'м', "m" },
			{ 'н', "n" },
			{ 'о', "o" },
			{ 'п', "p" },
			{ 'р', "r" },
			{ 'с', "s" },
			{ 'т', "t" },
			{ 'у', "u" },
			{ 'ф', "f" },
			{ 'х', "h" },
			{ 'ц', "c" },
			{ 'ч', "ch" },
			{ 'ш', "sh" },
			{ 'щ', "sch" },
			{ 'ъ', "j" },
			{ 'ы', "i" },
			{ 'ь', "j" },
			{ 'э', "e" },
			{ 'ю', "yu" },
			{ 'я', "ya" },
			{ 'А', "A" },
			{ 'Б', "B" },
			{ 'В', "V" },
			{ 'Г', "G" },
			{ 'Д', "D" },
			{ 'Е', "E" },
			{ 'Ё', "Yo" },
			{ 'Ж', "Zh" },
			{ 'З', "Z" },
			{ 'И', "I" },
			{ 'Й', "J" },
			{ 'К', "K" },
			{ 'Л', "L" },
			{ 'М', "M" },
			{ 'Н', "N" },
			{ 'О', "O" },
			{ 'П', "P" },
			{ 'Р', "R" },
			{ 'С', "S" },
			{ 'Т', "T" },
			{ 'У', "U" },
			{ 'Ф', "F" },
			{ 'Х', "H" },
			{ 'Ц', "C" },
			{ 'Ч', "Ch" },
			{ 'Ш', "Sh" },
			{ 'Щ', "Sch" },
			{ 'Ъ', "J" },
			{ 'Ы', "I" },
			{ 'Ь', "J" },
			{ 'Э', "E" },
			{ 'Ю', "Yu" },
			{ 'Я', "Ya" }
		};
		SendReportsByWebhooks = false;
		RemoteProcedureCalls.RegisterCommand(typeof(CheaterReport), "System.Void CheaterReport::CmdReport(System.UInt32,System.String,System.Byte[],System.Boolean)", InvokeUserCode_CmdReport__UInt32__String__Byte_005B_005D__Boolean, requiresAuthority: true);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_CmdReport__UInt32__String__Byte_005B_005D__Boolean(uint playerNetId, string reason, byte[] signature, bool notifyGm)
	{
		if (!_commandRateLimit.CanExecute() || reason == null)
		{
			return;
		}
		float num = Time.time - _lastReport;
		if (num < 2f)
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Reporting rate limit exceeded (1).", "red");
			return;
		}
		if (num > 60f)
		{
			_reportedPlayersAmount = 0;
		}
		if (_reportedPlayersAmount > 5)
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Reporting rate limit exceeded (2).", "red");
			return;
		}
		if (notifyGm && (!CustomNetworkManager.IsVerified || string.IsNullOrEmpty(ServerConsole.Password)))
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Server is not verified - you can't use report feature on this server.", "red");
			return;
		}
		if (!ReferenceHub.TryGetHubNetID(playerNetId, out var hub))
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Can't find player with that PlayerID.", "red");
			return;
		}
		PlayerAuthenticationManager reportedPam = hub.authManager;
		if (_reportedPlayers == null)
		{
			_reportedPlayers = new HashSet<uint>();
		}
		if (_reportedPlayers.Contains(playerNetId))
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] You have already reported that player.", "red");
			return;
		}
		if (string.IsNullOrEmpty(reportedPam.UserId))
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Failed: User ID of reported player is null.", "red");
			return;
		}
		if (string.IsNullOrEmpty(_hub.authManager.UserId))
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Failed: your User ID of is null.", "red");
			return;
		}
		if (_hub.authManager.UserId == reportedPam.UserId)
		{
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] You can't report yourself!" + Environment.NewLine, "yellow");
			return;
		}
		string reportedNickname = hub.nicknameSync.MyNick;
		if (!notifyGm)
		{
			PlayerReportingPlayerEventArgs e = new PlayerReportingPlayerEventArgs(_hub, hub, reason);
			PlayerEvents.OnReportingPlayer(e);
			if (!e.IsAllowed)
			{
				return;
			}
			reason = e.Reason;
			GameCore.Console.AddLog("Player " + _hub.LoggedNameFromRefHub() + " reported player " + hub.LoggedNameFromRefHub() + " with reason " + reason + ".", Color.gray);
			_hub.gameConsoleTransmission.SendToClient("[REPORTING] Player report successfully sent to local administrators.", "green");
			SendStaffChatNotification(_hub.authManager.UserId, reportedPam.UserId, reason, _hub.nicknameSync.MyNick, reportedNickname);
			if (SendReportsByWebhooks)
			{
				Thread thread = new Thread(() =>
				{
					LogReport(_hub.gameConsoleTransmission, _hub.authManager.UserId, reportedPam.UserId, ref reason, playerNetId, notifyGm: false, _hub.nicknameSync.MyNick, reportedNickname);
				});
				thread.Priority = System.Threading.ThreadPriority.Lowest;
				thread.IsBackground = true;
				thread.Name = "Reporting player (locally) - " + reportedPam.UserId + " by " + _hub.authManager.UserId;
				thread.Start();
			}
			PlayerEvents.OnReportedPlayer(new PlayerReportedPlayerEventArgs(_hub, hub, reason));
		}
		else
		{
			if (signature == null)
			{
				return;
			}
			if (!ECDSA.VerifyBytes(reportedPam.SyncedUserId + ";" + ConvertToLatin(reason), signature, _hub.authManager.AuthenticationResponse.PublicKey))
			{
				_hub.gameConsoleTransmission.SendToClient("[REPORTING] Invalid report signature.", "red");
				return;
			}
			PlayerReportingCheaterEventArgs e2 = new PlayerReportingCheaterEventArgs(_hub, hub, reason);
			PlayerEvents.OnReportingCheater(e2);
			if (e2.IsAllowed)
			{
				reason = e2.Reason;
				_lastReport = Time.time;
				_reportedPlayersAmount++;
				GameCore.Console.AddLog("Player " + _hub.LoggedNameFromRefHub() + " reported player " + hub.LoggedNameFromRefHub() + " with reason " + reason + ". Sending report to Global Moderation.", Color.gray);
				SendStaffChatNotification(_hub.authManager.UserId, reportedPam.UserId, reason, _hub.nicknameSync.MyNick, reportedNickname);
				Thread thread2 = new Thread(() =>
				{
					IssueReport(_hub.gameConsoleTransmission, _hub.authManager.UserId, reportedPam.UserId, reportedPam.GetAuthToken(), reportedPam.connectionToClient.address, _hub.authManager.GetAuthToken(), _hub.connectionToClient.address, ref reason, ref signature, ECDSA.KeyToString(_hub.authManager.AuthenticationResponse.PublicKey), playerNetId, _hub.nicknameSync.MyNick, reportedNickname);
				});
				thread2.Priority = System.Threading.ThreadPriority.Lowest;
				thread2.IsBackground = true;
				thread2.Name = "Reporting player - " + reportedPam.UserId + " by " + _hub.authManager.UserId;
				thread2.Start();
				PlayerEvents.OnReportedCheater(new PlayerReportedCheaterEventArgs(_hub, hub, reason));
			}
		}
	}

	protected static void InvokeUserCode_CmdReport__UInt32__String__Byte_005B_005D__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkServer.active)
		{
			Debug.LogError("Command CmdReport called on client.");
		}
		else
		{
			((CheaterReport)obj).UserCode_CmdReport__UInt32__String__Byte_005B_005D__Boolean(reader.ReadUInt(), reader.ReadString(), reader.ReadBytesAndSize(), reader.ReadBool());
		}
	}
}
