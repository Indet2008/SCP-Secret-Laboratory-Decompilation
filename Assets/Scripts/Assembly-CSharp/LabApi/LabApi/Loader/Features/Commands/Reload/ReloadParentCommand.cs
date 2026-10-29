namespace LabApi.Loader.Features.Commands.Reload
{
	[global::CommandSystem.CommandHandler(typeof(global::LabApi.Loader.Features.Commands.LabApiParentCommand))]
	public class ReloadParentCommand : ParentCommand
	{
		public override string Command => "reload";

		public override string[] Aliases => new string[2] { "r", "rl" };

		public override string Description => "Parent command for all reloading related sub commands.";

		public override void LoadGeneratedCommands()
		{
		}

		protected override bool ExecuteParent(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response)
		{
			return global::LabApi.Loader.Features.Commands.Extensions.CommandExtensions.ListSubCommands(this, arguments, out response);
		}
	}
}
