using System;
using System.Collections.Generic;
using Respawning.Waves;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public abstract class TargetWaveCommandBase : ICommand
	{
		private static readonly Dictionary<Type, string[]> WaveAliases = new Dictionary<Type, string[]>
		{
			[typeof(NtfSpawnWave)] = new string[4] { "NTF", "MTF", "MobileTaskForces", "NineTailedFox" },
			[typeof(ChaosSpawnWave)] = new string[3] { "CI", "Chaos", "ChaosInsurgency" },
			[typeof(NtfMiniWave)] = new string[4] { "NTFMini", "MTFMini", "MiniMTF", "MiniNTF" },
			[typeof(ChaosMiniWave)] = new string[4] { "ChaosMini", "CIMini", "MiniCI", "MiniChaos" }
		};

		public abstract string Command { get; }

		public abstract string[] Aliases { get; }

		public abstract string Description { get; }

		public abstract bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response);

		protected static string TranslateWaveName(string input)
		{
			foreach (KeyValuePair<Type, string[]> waveAlias in WaveAliases)
			{
				if (waveAlias.Value.Contains(input, StringComparison.OrdinalIgnoreCase))
				{
					return waveAlias.Key.Name;
				}
			}
			return input;
		}
	}
}
