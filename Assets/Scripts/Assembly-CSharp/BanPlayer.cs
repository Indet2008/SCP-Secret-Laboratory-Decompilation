using CommandSystem;
using Footprinting;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using NorthwoodLib;
using RemoteAdmin;

public static class BanPlayer
{
	private const string _globalBanReason = "You have been Globally Banned.";

	public static void GlobalBanUser(ReferenceHub target, ICommandSender issuer, string message)
	{
		if (ConfigFile.ServerConfig.GetBool("gban_ban_ip"))
		{
			ApplyIpBan(target, issuer, "You have been Globally Banned.", 4294967295L);
		}
		ServerConsole.Disconnect(target.gameObject, StringUtils.Base64Decode(message));
	}

	public static bool KickUser(ReferenceHub target, ICommandSender issuer, string reason)
	{
		ReferenceHub issuer2 = ((issuer is PlayerCommandSender playerCommandSender) ? playerCommandSender.ReferenceHub : ReferenceHub.HostHub);
		PlayerKickingEventArgs e = new PlayerKickingEventArgs(target, issuer2, reason);
		PlayerEvents.OnKicking(e);
		if (!e.IsAllowed)
		{
			return false;
		}
		reason = e.Reason;
		ServerConsole.Disconnect(target.gameObject, "You have been kicked. Reason: " + reason);
		PlayerEvents.OnKicked(new PlayerKickedEventArgs(target, issuer2, reason));
		return true;
	}

	public static bool KickUser(ReferenceHub target, ReferenceHub issuer, string reason)
	{
		return KickUser(target, new PlayerCommandSender(issuer), reason);
	}

	public static bool KickUser(ReferenceHub target, string reason)
	{
		return KickUser(target, ServerConsole.Scs, reason);
	}

	public static bool BanUser(ReferenceHub target, string reason, long duration)
	{
		return BanUser(target, ServerConsole.Scs, reason, duration);
	}

	public static bool BanUser(Footprint target, string reason, long duration)
	{
		return BanUser(target, ServerConsole.Scs, reason, duration);
	}

	public static bool BanUser(ReferenceHub target, ReferenceHub issuer, string reason, long duration)
	{
		return BanUser(target, new PlayerCommandSender(issuer), reason, duration);
	}

	public static bool BanUser(ReferenceHub target, ICommandSender issuer, string reason, long duration)
	{
		return BanUser(new Footprint(target), issuer, reason, duration);
	}

	public static bool BanUser(Footprint target, ICommandSender issuer, string reason, long duration)
	{
		if (duration == 0L && target.Hub != null)
		{
			return KickUser(target.Hub, issuer, reason);
		}
		if (target.BypassStaff)
		{
			return false;
		}
		ReferenceHub issuer2 = ((issuer is PlayerCommandSender playerCommandSender) ? playerCommandSender.ReferenceHub : ReferenceHub.HostHub);
		PlayerBanningEventArgs e = new PlayerBanningEventArgs(target.Hub, target.LogUserID, issuer2, reason, duration);
		PlayerEvents.OnBanning(e);
		if (!e.IsAllowed)
		{
			return false;
		}
		duration = e.Duration;
		reason = e.Reason;
		ApplyIpBan(target, issuer, reason, duration);
		long issuanceTime = TimeBehaviour.CurrentTimestamp();
		long banExpirationTime = TimeBehaviour.GetBanExpirationTime((uint)duration);
		string originalName = ValidateNick(target.Nickname);
		if (!string.IsNullOrEmpty(target.LogUserID))
		{
			BanHandler.IssueBan(new BanDetails
			{
				OriginalName = originalName,
				Id = target.LogUserID,
				IssuanceTime = issuanceTime,
				Expires = banExpirationTime,
				Reason = reason,
				Issuer = issuer.LogName
			}, BanHandler.BanType.UserId);
		}
		PlayerEvents.OnBanned(new PlayerBannedEventArgs(target.Hub, target.LogUserID, issuer2, reason, duration));
		if (target.Hub != null)
		{
			ServerConsole.Disconnect(target.Hub.gameObject, "You have been banned. Reason: " + reason);
		}
		return true;
	}

	public static void ApplyIpBan(ReferenceHub target, ICommandSender issuer, string reason, long duration)
	{
		ApplyIpBan(new Footprint(target), issuer, reason, duration);
	}

	public static void ApplyIpBan(Footprint target, ICommandSender issuer, string reason, long duration)
	{
		if (ConfigFile.ServerConfig.GetBool("ip_banning") && !string.IsNullOrEmpty(target.IpAddress))
		{
			long issuanceTime = TimeBehaviour.CurrentTimestamp();
			long banExpirationTime = TimeBehaviour.GetBanExpirationTime((uint)duration);
			BanHandler.IssueBan(new BanDetails
			{
				OriginalName = ValidateNick(target.Nickname),
				Id = target.IpAddress,
				IssuanceTime = issuanceTime,
				Expires = banExpirationTime,
				Reason = reason,
				Issuer = issuer.LogName
			}, BanHandler.BanType.IP);
		}
	}

	public static string ValidateNick(string username)
	{
		int num = ConfigFile.ServerConfig.GetInt("ban_nickname_maxlength", 30);
		bool num2 = ConfigFile.ServerConfig.GetBool("ban_nickname_trimunicode", def: true);
		string text = (string.IsNullOrEmpty(username) ? "(no nick)" : username);
		if (num2)
		{
			text = StringUtils.StripUnicodeCharacters(text);
		}
		if (text.Length > num)
		{
			text = text.Substring(0, num);
		}
		return text;
	}
}
