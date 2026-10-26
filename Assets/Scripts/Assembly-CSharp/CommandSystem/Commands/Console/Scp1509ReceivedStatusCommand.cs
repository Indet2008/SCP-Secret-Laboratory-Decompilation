using System;
using System.Collections.Generic;
using System.Text;
using InventorySystem.Items.Scp1509;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class Scp1509ReceivedStatusCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "1509";

		public string[] Aliases { get; }

		public string Description { get; } = "poggers";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("[1509] Start");
			foreach (KeyValuePair<ushort, bool> resurrectStatus in Scp1509Item.ResurrectStatuses)
			{
				stringBuilder.AppendLine($"{resurrectStatus.Key}:{resurrectStatus.Value}");
			}
			stringBuilder.AppendLine("[1509] End");
			response = stringBuilder.ToString();
			return true;
		}
	}
}
