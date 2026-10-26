namespace CommandSystem
{
	public interface ICommand
	{
		string Command { get; }

		string[] Aliases { get; }

		string Description { get; }

		bool Execute(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response);
	}
}
