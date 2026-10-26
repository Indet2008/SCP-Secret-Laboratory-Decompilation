using System;
using System.Collections.Generic;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class KeyCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "enkey";

		public string[] Aliases { get; }

		public string Description { get; } = "Displays an encryption key of a selected player(s).";

		public string[] Usage { get; } = new string[1] { "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PlayerSensitiveDataAccess, out response))
			{
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			if (!EncryptedChannelManager.CryptographyDebug)
			{
				response = "This command is disabled on this server!\nDO NOT ENABLE IT if you don't know what you are doing!\nEnabling this command is a SECURITY RISK. This is meant only for debugging purposes!";
				return false;
			}
			List<ReferenceHub> list = ((!(sender is PlayerCommandSender playerCommandSender) || (arguments.Count != 0 && (arguments.Count != 1 || arguments.At(0).Contains(".") || arguments.At(0).Contains("@")))) ? RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _) : new List<ReferenceHub> { playerCommandSender.ReferenceHub });
			if (list == null || list.Count == 0)
			{
				response = "No players specified!";
				return false;
			}
			response = "Encryption keys:\n";
			foreach (ReferenceHub item in list)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " displayed encryption key of " + item.LoggedNameFromRefHub() + ". THIS SHOULD NOT HAPPEN IF IT'S NOT A TEST! THIS IS A SECURITY RISK!", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				response = response + item.LoggedNameFromRefHub() + ": " + ((item.encryptedChannelManager.EncryptionKey == null) ? "(null)" : BitConverter.ToString(item.encryptedChannelManager.EncryptionKey)) + "\n";
			}
			return true;
		}
	}
}
