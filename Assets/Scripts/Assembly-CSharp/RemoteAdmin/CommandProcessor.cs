using System;
using System.Collections.Generic;
using System.Linq;
using CentralAuth;
using CommandSystem;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using LabApi.Features.Enums;
using PlayerStatsSystem;
using RemoteAdmin.Communication;
using UnityEngine;

namespace RemoteAdmin
{
	public static class CommandProcessor
	{
		private const int MaxStaffChatMessageLength = 2000;

		public static readonly RemoteAdminCommandHandler RemoteAdminCommandHandler = RemoteAdminCommandHandler.Create();

		internal static void ProcessAdminChat(string q, CommandSender sender)
		{
			if (!CheckPermissions(sender, "Admin Chat", PlayerPermissions.AdminChat, string.Empty))
			{
				if (sender is PlayerCommandSender playerCommandSender)
				{
					playerCommandSender.ReferenceHub.gameConsoleTransmission.SendToClient("You don't have permissions to access Admin Chat!", "red");
					playerCommandSender.RaReply("You don't have permissions to access Admin Chat!", success: false, logToConsole: true, "");
				}
				return;
			}
			uint num = 0u;
			ReferenceHub hub;
			if (sender is PlayerCommandSender playerCommandSender2)
			{
				num = playerCommandSender2.ReferenceHub.netId;
			}
			else if (ReferenceHub.TryGetLocalHub(out hub))
			{
				num = hub.netId;
			}
			q = Misc.SanitizeRichText(q.Replace("~", "-"), "[", "]").Trim();
			if (string.IsNullOrWhiteSpace(q.Replace("@", string.Empty)))
			{
				return;
			}
			if (q.Length > 2000)
			{
				q = q.Substring(0, 2000) + "...";
			}
			SendingAdminChatEventArgs e = new SendingAdminChatEventArgs(sender, q);
			ServerEvents.OnSendingAdminChat(e);
			if (!e.IsAllowed)
			{
				if (sender is PlayerCommandSender playerCommandSender3)
				{
					playerCommandSender3.ReferenceHub.gameConsoleTransmission.SendToClient("A server plugin cancelled the message.", "red");
					playerCommandSender3.RaReply("A server plugin cancelled the message.", success: false, logToConsole: true, "");
				}
				return;
			}
			q = e.Message;
			string content = num + "!" + q;
			if (ServerStatic.IsDedicated)
			{
				ServerConsole.AddLog("[AC " + sender.LogName + "] " + q, ConsoleColor.DarkYellow);
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, "[" + sender.LogName + "] " + q, ServerLogs.ServerLogType.AdminChat);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				ClientInstanceMode mode = allHub.Mode;
				if (mode != ClientInstanceMode.Unverified && mode != ClientInstanceMode.DedicatedServer && allHub.serverRoles.AdminChatPerms)
				{
					allHub.encryptedChannelManager.TrySendMessageToClient(content, EncryptedChannelManager.EncryptedChannel.AdminChat);
				}
			}
			ServerEvents.OnSentAdminChat(new SentAdminChatEventArgs(sender, q));
		}

		internal static string ProcessQuery(string q, CommandSender sender)
		{
			if (q.StartsWith("$", StringComparison.Ordinal))
			{
				string[] array = q.Remove(0, 1).Split(' ');
				if (array.Length <= 1)
				{
					return null;
				}
				if (!int.TryParse(array[0], out var result))
				{
					return null;
				}
				if (CommunicationProcessor.ServerCommunication.TryGetValue(result, out var value))
				{
					value.ReceiveData(sender, string.Join(" ", array.Skip(1)));
				}
				return null;
			}
			string[] array2 = q.Trim().Split(QueryProcessor.SpaceArray, 512, StringSplitOptions.RemoveEmptyEntries);
			bool flag = RemoteAdminCommandHandler.TryGetCommand(array2[0], out var command);
			ArraySegment<string> arguments = array2.Segment(1);
			CommandExecutingEventArgs e = new CommandExecutingEventArgs(sender, CommandType.RemoteAdmin, flag, command, arguments);
			ServerEvents.OnCommandExecuting(e);
			if (!e.IsAllowed)
			{
				return null;
			}
			arguments = e.Arguments;
			sender = e.Sender;
			command = e.Command;
			if (flag)
			{
				try
				{
					bool successful = command.Execute(arguments, sender, out var response);
					response = Misc.CloseAllRichTextTags(response);
					CommandExecutedEventArgs e2 = new CommandExecutedEventArgs(sender, CommandType.RemoteAdmin, command, arguments, successful, response);
					ServerEvents.OnCommandExecuted(e2);
					response = e2.Response;
					successful = e2.ExecutedSuccessfully;
					if (!string.IsNullOrEmpty(response))
					{
						sender.RaReply(array2[0].ToUpperInvariant() + "#" + response, successful, logToConsole: true, "");
					}
					return response;
				}
				catch (Exception ex)
				{
					string response2 = "Command execution failed! Error: " + Misc.RemoveStacktraceZeroes(ex.ToString());
					CommandExecutedEventArgs e3 = new CommandExecutedEventArgs(sender, CommandType.RemoteAdmin, command, arguments, successful: false, response2);
					ServerEvents.OnCommandExecuted(e3);
					response2 = e3.Response;
					sender.RaReply(response2, success: false, logToConsole: true, array2[0].ToUpperInvariant() + "#" + response2);
					return response2;
				}
			}
			sender.RaReply("SYSTEM#Unknown command!", success: false, logToConsole: true, string.Empty);
			return "Unknown command!";
		}

		internal static float GetRoundedStat<T>(ReferenceHub hub) where T : StatBase
		{
			return Mathf.Round(hub.playerStats.GetModule<T>().CurValue * 100f) / 100f;
		}

		internal static List<ICommand> GetAllCommands()
		{
			return RemoteAdminCommandHandler.AllCommands.ToList();
		}

		private static bool CheckPermissions(CommandSender sender, string queryZero, PlayerPermissions perm, string replyScreen = "", bool reply = true)
		{
			if (ServerStatic.IsDedicated && sender.FullPermissions)
			{
				return true;
			}
			if (PermissionsHandler.IsPermitted(sender.Permissions, perm))
			{
				return true;
			}
			if (reply)
			{
				sender.RaReply(queryZero + "#You don't have permissions to execute this command.\nRequired permission: " + perm, success: false, logToConsole: true, replyScreen);
			}
			return false;
		}

		internal static bool CheckPermissions(CommandSender sender, PlayerPermissions perm)
		{
			if (ServerStatic.IsDedicated && sender.FullPermissions)
			{
				return true;
			}
			if (PermissionsHandler.IsPermitted(sender.Permissions, perm))
			{
				return true;
			}
			return false;
		}
	}
}
