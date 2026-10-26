using System;
using GameCore;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ReloadConfigCommand : ICommand
	{
		public string Command { get; } = "reloadconfig";

		public string[] Aliases { get; } = new string[1] { "rc" };

		public string Description { get; } = "Reloads all configs.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " reloaded configuration files.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			try
			{
				ConfigFile.ReloadGameConfigs();
				response = "Reloaded all configs!";
				return true;
			}
			catch (Exception arg)
			{
				response = $"Reloading configs failed: {arg}";
				return false;
			}
		}
	}
}
