using System;
using Cassie;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CassieSilentCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "cassie_silent";

		public string[] Aliases { get; } = new string[3] { "cassie_silentnoise", "cassie_sn", "cassie_sl" };

		public string Description { get; } = "Sends a silent (no preceding tone) announcement over the CASSIE system.";

		public string[] Usage { get; } = new string[1] { "message" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Announcer, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			string text = RAUtils.FormatArguments(arguments, 0).ToUpper();
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " started a silent cassie announcement: " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			new CassieAnnouncement(new CassieTtsPayload(text, autoGenerateSubtitles: true, playBackground: false), 0f, 0f).AddToQueue();
			response = "Silent announcement sent!";
			return true;
		}
	}
}
