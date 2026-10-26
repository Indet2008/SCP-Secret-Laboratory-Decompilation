using System;
using System.Text;
using CommandSystem;
using NorthwoodLib.Pools;

namespace _Scripts.CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class QueryCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "query";

		public string[] Aliases { get; }

		public string Description { get; } = "Manages query client connections.";

		public string[] Usage { get; } = new string[1] { "kickall (optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (CustomNetworkManager.QueryServer == null)
			{
				response = "Query server is not initialized.";
				return false;
			}
			if (arguments.Count == 0)
			{
				if (CustomNetworkManager.QueryServer.Users.Count == 0)
				{
					response = "There are no query clients connected.";
					return true;
				}
				StringBuilder stringBuilder = StringBuilderPool.Shared.Rent("Connected query clients:\n");
				try
				{
					for (int i = 0; i < CustomNetworkManager.QueryServer.Users.Count; i++)
					{
						stringBuilder.AppendFormat(" - {0}\n", CustomNetworkManager.QueryServer.Users[i]);
					}
				}
				catch (Exception ex)
				{
					stringBuilder.AppendFormat("\n\nAn exception occured while listing query clients: {0}\n{1}", ex.Message, ex.StackTrace);
				}
				finally
				{
					response = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
				}
				return true;
			}
			string text = arguments.At(0).ToLowerInvariant();
			if (text == "kickall" || text == "ka")
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disconnected all query clients.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				CustomNetworkManager.QueryServer.DisconnectAllClients();
				response = "All query clients have been disconnected.";
				return true;
			}
			response = "Unknown subcommand.\nUsage: " + Command + " " + this.DisplayCommandUsage() + ".";
			return false;
		}
	}
}
