using System;
using System.Threading.Tasks;
using GameCore;
using UnityEngine;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class IpCommand : ICommand
	{
		public string Command { get; } = "ip";

		public string[] Aliases { get; } = new string[2] { "whatismyip", "myip" };

		public string Description { get; } = "Returns the IP used when connecting to central servers";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			try
			{
				Task.Run(async () =>
				{
					string ip = await HttpQuery.GetAsync(CentralServer.StandardUrl + "ip.php");
					MainThreadDispatcher.Dispatch(() =>
					{
						GameCore.Console.AddLog("IP: " + (ip.EndsWith('.') ? ip.Remove(ip.Length - 1) : ip), Color.green);
					});
				});
				response = "Requesting IP...";
				return true;
			}
			catch (Exception ex)
			{
				response = "HTTP request failed: " + ex.Message;
				return false;
			}
		}
	}
}
