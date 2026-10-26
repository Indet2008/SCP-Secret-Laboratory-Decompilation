using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using RemoteAdmin;
using Utils;
using VoiceChat;

namespace CommandSystem.Commands.RemoteAdmin.MutingAndIntercom
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class IntercomMuteCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "imute";

		public string[] Aliases { get; }

		public string Description { get; } = "Prevents the specified player(s) from being able to speak over the intercom.";

		public string[] Usage { get; } = new string[1] { "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(new PlayerPermissions[3]
			{
				PlayerPermissions.BanningUpToDay,
				PlayerPermissions.LongTermBanning,
				PlayerPermissions.PlayersManagement
			}, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			ReferenceHub issuer = ((sender is PlayerCommandSender playerCommandSender) ? playerCommandSender.ReferenceHub : ReferenceHub.HostHub);
			int num = 0;
			if (list != null)
			{
				foreach (ReferenceHub item in list)
				{
					PlayerMutingEventArgs e = new PlayerMutingEventArgs(item, issuer, isIntercom: true);
					PlayerEvents.OnMuting(e);
					if (e.IsAllowed)
					{
						VoiceChatMutes.IssueLocalMute(item.authManager.UserId, intercom: true);
						PlayerEvents.OnMuted(new PlayerMutedEventArgs(item, issuer, isIntercom: true));
						ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " issued an intercom mute to player " + item.LoggedNameFromRefHub() + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
						num++;
					}
				}
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
