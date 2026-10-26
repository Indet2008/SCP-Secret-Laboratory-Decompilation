using System;
using System.Text;
using NorthwoodLib.Pools;
using Respawning;
using Respawning.Waves;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(WaveCommand))]
	public class WaveListCommand : ICommand
	{
		public string Command { get; } = "list";

		public string[] Aliases { get; } = new string[3] { "lst", "ls", "l" };

		public string Description { get; } = "Prints all the currently existing waves.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RespawnEvents, out response))
			{
				return false;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent("These are all the existing waves:");
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				string name = wave.GetType().Name;
				stringBuilder.Append("\n- ");
				stringBuilder.Append(name);
			}
			response = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			return true;
		}
	}
}
