using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using Respawning;
using Respawning.Waves;
using Respawning.Waves.Generic;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public class WaveSetCommand : TargetWaveCommandBase
	{
		public static Dictionary<UpdateMessageFlags, Func<SpawnableWaveBase, string, bool>> MethodPerFlag = new Dictionary<UpdateMessageFlags, Func<SpawnableWaveBase, string, bool>>
		{
			[UpdateMessageFlags.Pause] = (SpawnableWaveBase w, string input) => SetPause(w, input),
			[UpdateMessageFlags.Timer] = (SpawnableWaveBase w, string input) => SetTimer(w, input),
			[UpdateMessageFlags.Tokens] = (SpawnableWaveBase w, string input) => SetTokens(w, input),
			[UpdateMessageFlags.Trigger] = (SpawnableWaveBase w, string input) => PlayAnimation(w, input),
			[UpdateMessageFlags.None] = (SpawnableWaveBase w, string input) => SetInfluence(w, input)
		};

		public override string Command { get; } = "set";

		public override string[] Aliases { get; } = new string[2] { "st", "s" };

		public override string Description { get; } = "Sets the value of the specified flag.";

		public override bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RespawnEvents, out response))
			{
				return false;
			}
			if (arguments.Count <= 2)
			{
				response = InvalidFlagMessage("Not enough arguments");
				return false;
			}
			string text = TargetWaveCommandBase.TranslateWaveName(arguments.At(0));
			string text2 = arguments.At(1);
			if (string.Compare(text2, "influence", ignoreCase: true) == 0)
			{
				text2 = "None";
			}
			if (!Enum.TryParse<UpdateMessageFlags>(text2, ignoreCase: true, out var result))
			{
				response = InvalidFlagMessage("Specified flag does not exist");
				return false;
			}
			if (!MethodPerFlag.TryGetValue(result, out var value))
			{
				response = InvalidFlagMessage("Specified flag has no specified action");
				return false;
			}
			string text3 = arguments.At(2);
			bool flag = false;
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				string name = wave.GetType().Name;
				if (name.Equals(text, StringComparison.OrdinalIgnoreCase) && value(wave, text3))
				{
					text = name;
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				response = InvalidFlagMessage("No wave was found");
				return false;
			}
			response = $"Set {text}'s {result} to {text3}.";
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} set {text}'s {result} to {text3}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}

		private string InvalidFlagMessage(string context)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append(context);
			stringBuilder.Append(". The correct syntax is \"wave ");
			stringBuilder.Append(Command);
			stringBuilder.Append(" <wave> <flag> <value>\". Available flags:");
			foreach (UpdateMessageFlags key in MethodPerFlag.Keys)
			{
				stringBuilder.Append("\n- ");
				stringBuilder.Append(key);
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private static bool SetTokens(SpawnableWaveBase wave, string value)
		{
			if (!(wave is ILimitedWave limitedWave))
			{
				return false;
			}
			if (!int.TryParse(value, out var result))
			{
				return false;
			}
			if (value.StartsWith('+') || value.StartsWith('-'))
			{
				result = limitedWave.RespawnTokens + result;
			}
			result = Math.Clamp(result, 0, int.MaxValue);
			limitedWave.RespawnTokens = result;
			WaveUpdateMessage.ServerSendUpdate(wave, UpdateMessageFlags.Tokens);
			return true;
		}

		private static bool SetTimer(SpawnableWaveBase wave, string value)
		{
			if (!(wave is TimeBasedWave timeBasedWave))
			{
				return false;
			}
			if (!float.TryParse(value, out var result))
			{
				return false;
			}
			if (value.StartsWith('+') || value.StartsWith('-'))
			{
				timeBasedWave.Timer.AddTime(result);
				return true;
			}
			timeBasedWave.Timer.SetTime(result);
			return true;
		}

		private static bool SetPause(SpawnableWaveBase wave, string value)
		{
			if (!(wave is TimeBasedWave timeBasedWave))
			{
				return false;
			}
			if (!float.TryParse(value, out var result))
			{
				return false;
			}
			timeBasedWave.Timer.Pause(result);
			return true;
		}

		private static bool PlayAnimation(SpawnableWaveBase wave, string _)
		{
			if (!(wave is IAnimatedWave))
			{
				return false;
			}
			WaveUpdateMessage.ServerSendUpdate(wave, UpdateMessageFlags.Trigger);
			return true;
		}

		private static bool SetInfluence(SpawnableWaveBase wave, string value)
		{
			if (!float.TryParse(value, out var result))
			{
				return false;
			}
			if (value.StartsWith('+') || value.StartsWith('-'))
			{
				result = FactionInfluenceManager.Get(wave.TargetFaction) + result;
			}
			result = Mathf.Clamp(result, 0f, float.MaxValue);
			FactionInfluenceManager.Set(wave.TargetFaction, result);
			return true;
		}
	}
}
