using System;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class StripdownCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "stripdown";

		public override string[] Aliases => null;

		public override string Description { get; } = "Advanced debug command. Allows to print out properties and fields of any instantiated object.";

		public string[] Usage { get; } = new string[1] { "SubCommand" };

		public static StripdownCommand Create()
		{
			StripdownCommand stripdownCommand = new StripdownCommand();
			stripdownCommand.LoadGeneratedCommands();
			return stripdownCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			response = "Please specify a valid subcommand:";
			foreach (ICommand allCommand in AllCommands)
			{
				response = response + "\n" + allCommand.Command + " - " + allCommand.Description;
			}
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new StripdownComponentCommand());
			RegisterCommand(new StripdownObjectCommand());
			RegisterCommand(new StripdownPrintCommand());
			RegisterCommand(new StripdownValueCommand());
		}
	}
}
