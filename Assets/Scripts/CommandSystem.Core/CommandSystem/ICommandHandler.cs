namespace CommandSystem
{
	public interface ICommandHandler
	{
		global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> AllCommands { get; }

		bool TryGetCommand(string query, out global::CommandSystem.ICommand command);

		void RegisterCommand(global::CommandSystem.ICommand command);

		void UnregisterCommand(global::CommandSystem.ICommand command);

		void ClearCommands();

		void LoadGeneratedCommands();
	}
}
