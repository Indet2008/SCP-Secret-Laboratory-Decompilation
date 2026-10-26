using System;
using Respawning;
using Respawning.Waves;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public class WaveForcePauseCommand : TargetWaveCommandBase
	{
		public override string Command { get; } = "forcepause";

		public override string[] Aliases { get; } = new string[1] { "pauseforce" };

		public override string Description { get; } = "Pauses the wave's timer by force. Preventing it from counting down.";

		public override bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RespawnEvents, out response))
			{
				return false;
			}
			string text = TargetWaveCommandBase.TranslateWaveName(arguments.At(0));
			bool flag = false;
			SpawnableWaveBase spawnableWaveBase = null;
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				string name = wave.GetType().Name;
				if (name.Equals(text, StringComparison.OrdinalIgnoreCase))
				{
					text = name;
					spawnableWaveBase = wave;
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				response = "Specified wave not found";
				return false;
			}
			if (!(spawnableWaveBase is TimeBasedWave timeBasedWave))
			{
				response = "Specified wave is not time based";
				return false;
			}
			bool result = !timeBasedWave.Timer.IsForcefullyPaused;
			if (arguments.Count > 1 && !bool.TryParse(arguments.At(1), out result))
			{
				response = "Unable to parse boolean value of the pause status";
				return false;
			}
			timeBasedWave.Timer.IsForcefullyPaused = result;
			response = "Wave " + text + " timer is " + (timeBasedWave.Timer.IsForcefullyPaused ? "now paused" : "no longer paused") + ".";
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " set " + text + "'s wave timer to " + (timeBasedWave.Timer.IsForcefullyPaused ? "now paused" : "no longer paused") + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}
	}
}
