using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MapGeneration;
using NorthwoodLib.Pools;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RidListCommand : ICommand
	{
		public string Command { get; } = "ridlist";

		public string[] Aliases { get; } = new string[1] { "rids" };

		public string Description { get; } = "Displays a list of all room ids.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			RoomIdentifier[] array = RoomIdentifier.AllRoomIdentifiers.Where((RoomIdentifier x) => x.Name != RoomName.Unnamed).ToArray();
			if (array.Length == 0)
			{
				response = "There are no rooms!";
				return false;
			}
			Dictionary<RoomName, int> dictionary = new Dictionary<RoomName, int>();
			RoomIdentifier[] array2 = array;
			foreach (RoomIdentifier roomIdentifier in array2)
			{
				if (dictionary.TryGetValue(roomIdentifier.Name, out var value))
				{
					dictionary[roomIdentifier.Name] = value + 1;
				}
				else
				{
					dictionary.Add(roomIdentifier.Name, 1);
				}
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append("--- RID List ---\n");
			foreach (KeyValuePair<RoomName, int> item in dictionary.OrderBy((KeyValuePair<RoomName, int> a) => a.Key))
			{
				stringBuilder.Append("- ");
				stringBuilder.Append(item.Key);
				stringBuilder.Append(" (");
				stringBuilder.Append(item.Value);
				stringBuilder.Append(")\n");
			}
			response = stringBuilder.ToString().TrimEnd();
			StringBuilderPool.Shared.Return(stringBuilder);
			return true;
		}
	}
}
