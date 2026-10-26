using System;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CleanupCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "cleanup";

		public override string[] Aliases { get; } = new string[0];

		public override string Description { get; } = "Controls and cleans several elements of the map.";

		public string[] Usage { get; } = new string[1] { "ragdolls/items/decals/blood/bulletholes" };

		public static CleanupCommand Create()
		{
			CleanupCommand cleanupCommand = new CleanupCommand();
			cleanupCommand.LoadGeneratedCommands();
			return cleanupCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Please specify a valid subcommand (" + Usage[0] + ").";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new BloodCommand());
			RegisterCommand(new BulletHolesCommand());
			RegisterCommand(new CorpsesCommand());
			RegisterCommand(new ItemsCommand());
		}
	}
}
