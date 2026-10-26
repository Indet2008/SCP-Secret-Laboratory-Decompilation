using System;
using Interactables.Interobjects.DoorUtils;
using MEC;
using MapGeneration;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class LockdownCommand : ICommand, IUsageProvider
	{
		private CoroutineHandle _lockdownHandle;

		public string Command { get; } = "lockdown";

		public string[] Aliases { get; } = new string[1] { "ld" };

		public string Description { get; } = "Locks all the doors in the facility.";

		public string[] Usage { get; } = new string[2] { "ZoneID Filter", "Duration (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			FacilityZone result = FacilityZone.None;
			float result2 = 0f;
			if (arguments.Count != 0 && !Enum.TryParse<FacilityZone>(arguments.At(0), ignoreCase: true, out result))
			{
				response = "Specified zone is invalid.";
				return false;
			}
			if (arguments.Count > 1 && !float.TryParse(arguments.At(1), out result2))
			{
				response = "Specified duration is invalid.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} has locked down the facility (Filter: {result}){((result2 == 0f) ? string.Empty : $"for {result2} seconds.")}", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			Lockdown(result, result2, result2 != -1f, out response);
			return true;
		}

		private void Lockdown(FacilityZone zoneToAffect, float duration, bool doLock, out string commandResponse)
		{
			if (RoundSummary.SummaryActive)
			{
				commandResponse = string.Empty;
				return;
			}
			bool flag = zoneToAffect != FacilityZone.None;
			foreach (DoorVariant allDoor in DoorVariant.AllDoors)
			{
				if (!flag || allDoor.IsInZone(zoneToAffect))
				{
					allDoor.ServerChangeLock(DoorLockReason.AdminCommand, doLock);
				}
			}
			Timing.KillCoroutines(_lockdownHandle);
			if (duration != 0f)
			{
				_lockdownHandle = Timing.CallDelayed(duration, () =>
				{
					Lockdown(zoneToAffect, 0f, doLock: false, out var _);
				});
			}
			commandResponse = ((zoneToAffect == FacilityZone.None) ? ("Locked down the facility" + ((duration == 0f) ? "." : $" for {duration} seconds.")) : string.Format("Locked down {0}{1}", zoneToAffect, (duration == 0f) ? "." : $" for {duration} seconds."));
		}
	}
}
