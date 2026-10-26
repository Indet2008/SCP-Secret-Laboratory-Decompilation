using System;
using AdminToys;
using Mirror;
using RemoteAdmin;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SpawnToyCommand : ICommand, IUsageProvider
	{
		private const string ListCommand = "list";

		public string Command { get; } = "spawntoy";

		public string[] Aliases { get; }

		public string Description { get; } = "Spawns an admin toy.";

		public string[] Usage { get; } = new string[1] { "Target toy (Optional, will list all available toys if not provided)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "Only players can run this command.";
				return false;
			}
			string text = ((arguments.Count < 1) ? "list" : arguments.Array[1]);
			bool flag = text == "list";
			if (flag)
			{
				response = "List of toys:";
			}
			foreach (GameObject value in NetworkClient.prefabs.Values)
			{
				if (value.TryGetComponent<AdminToyBase>(out var component))
				{
					if (flag)
					{
						response = response + "\n- " + component.CommandName;
					}
					else if (string.Equals(text, component.CommandName, StringComparison.InvariantCultureIgnoreCase))
					{
						AdminToyBase adminToyBase = UnityEngine.Object.Instantiate(component);
						adminToyBase.OnSpawned(playerCommandSender.ReferenceHub, arguments);
						response = $"Toy \"{adminToyBase.CommandName}\" placed! You can remove it by using \"DESTROYTOY {adminToyBase.netId}\" command.";
						return true;
					}
				}
			}
			if (!flag)
			{
				response = "Toy \"" + text + "\" not found!";
			}
			return flag;
		}
	}
}
