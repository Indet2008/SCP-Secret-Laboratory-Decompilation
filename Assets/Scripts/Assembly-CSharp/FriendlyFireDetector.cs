using System.Threading;
using CentralAuth;
using Footprinting;
using PlayerStatsSystem;

internal class FriendlyFireDetector
{
	protected bool _triggered;

	private readonly ReferenceHub _hub;

	internal uint Kills { get; private set; }

	internal float Damage { get; private set; }

	internal FriendlyFireDetector(ReferenceHub hub)
	{
		_hub = hub;
	}

	public virtual bool RegisterDamage(float damage)
	{
		Damage += damage;
		return false;
	}

	public virtual bool RegisterKill()
	{
		Kills++;
		return false;
	}

	public virtual void Reset()
	{
		Kills = 0u;
		Damage = 0f;
	}

	protected void TakeAction(ref FriendlyFireAction action, string detector, ref long banDuration, ref string banReason, ref string killReason, ref string adminchat, ref string broadcast, ref bool webhook)
	{
		_triggered = true;
		TakeAction(new Footprint(_hub), ref action, detector, ref banDuration, ref banReason, ref killReason, ref adminchat, ref broadcast, ref webhook);
	}

	internal static void TakeAction(Footprint fp, ref FriendlyFireAction action, string detector, ref long banDuration, ref string banReason, ref string killReason, ref string adminchat, ref string broadcast, ref bool webhook)
	{
		string text = ((fp.Hub != null) ? fp.Hub.roleManager.CurrentRole.RoleTypeId.ToString() : fp.Role.ToString());
		if (!string.IsNullOrWhiteSpace(adminchat) && FriendlyFireConfig.AdminChatTime > 0)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.serverRoles.AdminChatPerms && allHub.Mode == ClientInstanceMode.ReadyClient)
				{
					allHub.queryProcessor.SendToClient(string.Format("@!{0} {1}", FriendlyFireConfig.AdminChatTime, adminchat.Replace("%nick", fp.Nickname)), isSuccess: true, logInConsole: false, string.Empty);
				}
			}
		}
		if (!string.IsNullOrWhiteSpace(broadcast) && FriendlyFireConfig.BroadcastTime > 0)
		{
			Broadcast.Singleton.RpcAddElement(broadcast.Replace("%nick", fp.Nickname), FriendlyFireConfig.BroadcastTime, Broadcast.BroadcastFlags.Normal);
		}
		if (webhook)
		{
			Thread thread = new Thread(() =>
			{
				CheaterReport.SubmitReport("Friendly Fire Detector", fp.LoggedNameFromFootprint(), "Friendly fire has been detected. Detector: " + detector + ".", fp.NetId, "Friendly Fire Detector", fp.Nickname, friendlyFire: true);
			});
			thread.Priority = ThreadPriority.BelowNormal;
			thread.Name = "TK Reporter";
			thread.IsBackground = true;
			thread.Start();
		}
		switch (action)
		{
		case FriendlyFireAction.Kill:
			if (fp.Hub != null)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Detector, fp.Hub.LoggedNameFromRefHub() + " playing as " + text + " has been automatically killed for teamkilling. Detector: " + detector + ".", ServerLogs.ServerLogType.Teamkill);
				fp.Hub.playerStats.DealDamage(new UniversalDamageHandler(-1f, DeathTranslations.FriendlyFireDetector));
			}
			break;
		case FriendlyFireAction.Kick:
			if (fp.Hub != null)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Detector, fp.Hub.LoggedNameFromRefHub() + " playing as " + text + " has been automatically kicked for teamkilling. Detector: " + detector + ".", ServerLogs.ServerLogType.Teamkill);
				BanPlayer.KickUser(fp.Hub, banReason);
			}
			break;
		case FriendlyFireAction.Ban:
			ServerLogs.AddLog(ServerLogs.Modules.Detector, $"{fp.LoggedNameFromFootprint()} playing as {text} has been automatically banned for teamkilling. Detector: {detector}. Duration: {banDuration} seconds.", ServerLogs.ServerLogType.Teamkill);
			BanPlayer.BanUser(fp, banReason, banDuration);
			break;
		}
	}
}
