namespace LabApi.Loader.Features.Commands
{
	[global::CommandSystem.CommandHandler(typeof(global::CommandSystem.RemoteAdminCommandHandler))]
	[global::CommandSystem.CommandHandler(typeof(global::CommandSystem.GameConsoleCommandHandler))]
	public class LabApiParentCommand : ParentCommand
	{
		public override string Command => "labapi";

		public override string[] Aliases => new string[1] { "lab" };

		public override string Description => "Parent command for all LabAPI subcommands.";

		public override void LoadGeneratedCommands()
		{
		}

		protected override bool ExecuteParent(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response)
		{
			return global::LabApi.Loader.Features.Commands.Extensions.CommandExtensions.ListSubCommands(this, arguments, out response);
		}
	}
}
