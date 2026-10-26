using System;
using System.Text;
using Mirror;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	[CommandHandler(typeof(StripdownCommand))]
	public abstract class StripdownInstructionBase : ICommand
	{
		private static readonly StringBuilder Combiner = new StringBuilder();

		public abstract string Command { get; }

		public string[] Aliases => null;

		public abstract string Description { get; }

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!ServerStatic.IsDedicated && ReferenceHub.TryGetLocalHub(out var hub) && !hub.serverRoles.RemoteAdmin)
			{
				response = "You need RA access to run this command on client!";
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			NetworkConnection connectionToClient;
			if (sender is PlayerCommandSender playerCommandSender)
			{
				connectionToClient = playerCommandSender.ReferenceHub.connectionToClient;
			}
			else
			{
				if (!(sender is ServerConsoleSender) || !ReferenceHub.TryGetLocalHub(out var hub2))
				{
					response = "No valid receiver found.";
					return false;
				}
				connectionToClient = hub2.connectionToClient;
			}
			Combiner.Clear();
			bool flag = false;
			for (int i = 0; i < arguments.Count; i++)
			{
				if (flag)
				{
					Combiner.Append(' ');
				}
				else
				{
					flag = true;
				}
				Combiner.Append(arguments.Array[arguments.Offset + i]);
			}
			response = ProcessInstruction(connectionToClient, Combiner.ToString());
			return true;
		}

		protected abstract string ProcessInstruction(NetworkConnection conn, string instruction);
	}
}
