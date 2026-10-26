namespace CommandSystem
{
	public abstract class CommandHandler : global::CommandSystem.ICommandHandler
	{
		protected readonly global::System.Collections.Generic.Dictionary<string, global::CommandSystem.ICommand> Commands = new global::System.Collections.Generic.Dictionary<string, global::CommandSystem.ICommand>(global::System.StringComparer.OrdinalIgnoreCase);

		protected readonly global::System.Collections.Generic.Dictionary<string, string> CommandAliases = new global::System.Collections.Generic.Dictionary<string, string>(global::System.StringComparer.OrdinalIgnoreCase);

		public virtual global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> AllCommands => Commands.Values;

		public virtual bool TryGetCommand(string query, out global::CommandSystem.ICommand command)
		{
			if (CommandAliases.TryGetValue(query, out var value))
			{
				query = value;
			}
			return Commands.TryGetValue(query, out command);
		}

		public virtual void RegisterCommand(global::CommandSystem.ICommand command)
		{
			if (string.IsNullOrWhiteSpace(command.Command))
			{
				throw new global::System.ArgumentException("Command text of " + command.GetType().Name + " cannot be null or whitespace!");
			}
			Commands.Add(command.Command, command);
			if (command.Aliases == null)
			{
				return;
			}
			string[] aliases = command.Aliases;
			foreach (string text in aliases)
			{
				if (!string.IsNullOrWhiteSpace(text))
				{
					CommandAliases.Add(text, command.Command);
				}
			}
		}

		public virtual void UnregisterCommand(global::CommandSystem.ICommand command)
		{
			Commands.Remove(command.Command);
			if (command.Aliases != null)
			{
				string[] aliases = command.Aliases;
				foreach (string key in aliases)
				{
					CommandAliases.Remove(key);
				}
			}
		}

		public virtual void ClearCommands()
		{
			Commands.Clear();
			CommandAliases.Clear();
		}

		public abstract void LoadGeneratedCommands();
	}
}
