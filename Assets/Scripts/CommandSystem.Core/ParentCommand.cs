public abstract class ParentCommand : global::CommandSystem.CommandHandler, global::CommandSystem.ICommand
{
	public abstract string Command { get; }

	public abstract string[] Aliases { get; }

	public abstract string Description { get; }

	public bool Execute(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response)
	{
		if (arguments.Count != 0 && TryGetCommand(arguments.Array[arguments.Offset], out var command))
		{
			return command.Execute(new global::System.ArraySegment<string>(arguments.Array, arguments.Offset + 1, arguments.Count - 1), sender, out response);
		}
		return ExecuteParent(arguments, sender, out response);
	}

	protected abstract bool ExecuteParent(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response);
}
