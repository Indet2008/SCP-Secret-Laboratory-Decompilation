using System;
using System.Text;
using NorthwoodLib.Pools;
using Respawning;
using Respawning.Waves;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public class WaveDebugCommand : ICommand
	{
		public string Command { get; } = "debug";

		public string[] Aliases { get; } = new string[3] { "get", "gt", "g" };

		public string Description { get; } = "Prints all the possible information about a wave.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RespawnEvents, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "You must specify a wave to get the information from.";
				return false;
			}
			string text = arguments.At(0);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				if (wave.GetType().Name.Contains(text, StringComparison.OrdinalIgnoreCase))
				{
					if (stringBuilder.Length > 0)
					{
						stringBuilder.Append("\n\n");
					}
					stringBuilder.Append(wave.CreateDebugString());
				}
			}
			response = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " requested information about " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}
	}
}
