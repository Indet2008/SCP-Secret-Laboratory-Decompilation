namespace LabApi.Loader.Features.Commands.Extensions
{
	public static class CommandExtensions
	{
		public static bool ListSubCommands(ParentCommand parent, global::System.ArraySegment<string> arguments, out string response)
		{
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			stringBuilder.AppendLine((arguments.Count > 0) ? ("'" + arguments.At(0) + "' was not a valid sub command.") : "You must specify a subcommand when executing this command.");
			stringBuilder.AppendLine("Valid subcommands:");
			foreach (global::CommandSystem.ICommand allCommand in parent.AllCommands)
			{
				stringBuilder.AppendLine("    " + allCommand.Command + " - " + allCommand.Description + " Aliases [" + string.Join(" ", allCommand.Aliases) + "]");
			}
			response = global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			return arguments.Count == 0;
		}
	}
}
