using System;
using System.Text;
using NorthwoodLib.Pools;
using Respawning;
using Respawning.Waves;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public class WaveSpawnCommand : TargetWaveCommandBase
	{
		public override string Command { get; } = "spawn";

		public override string[] Aliases { get; } = new string[3] { "sp", "fs", "force" };

		public override string Description { get; } = "Sets the value of the specified flag.";

		public override bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RespawnEvents, out response))
			{
				return false;
			}
			bool flag = false;
			if (arguments.Count <= 0)
			{
				response = InvalidFlagMessage("Not enough arguments");
				return false;
			}
			if (arguments.Count > 1)
			{
				flag = bool.TryParse(arguments.At(1), out var result) & result;
			}
			string text = TargetWaveCommandBase.TranslateWaveName(arguments.At(0));
			bool flag2 = false;
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				string name = wave.GetType().Name;
				if (name.Equals(text, StringComparison.OrdinalIgnoreCase))
				{
					if (flag)
					{
						WaveManager.Spawn(wave);
					}
					else
					{
						WaveManager.InitiateRespawn(wave);
					}
					text = name;
					flag2 = true;
					break;
				}
			}
			if (!flag2)
			{
				response = InvalidFlagMessage("No wave was found");
				return false;
			}
			string text2 = (flag ? "force spawned" : "spawned");
			response = "Action completed, " + text + " was " + text2 + ".";
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " " + text2 + " " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}

		private string InvalidFlagMessage(string context)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append(context);
			stringBuilder.Append(". The correct syntax is \"wave ");
			stringBuilder.Append(Command);
			stringBuilder.Append(" <wave> [forceSpawn? (true/false)]");
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
	}
}
