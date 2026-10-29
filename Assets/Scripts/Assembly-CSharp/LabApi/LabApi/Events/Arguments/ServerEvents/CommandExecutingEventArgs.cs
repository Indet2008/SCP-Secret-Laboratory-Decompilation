namespace LabApi.Events.Arguments.ServerEvents
{
	public class CommandExecutingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICommandSenderEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public CommandSender Sender { get; set; }

		public global::LabApi.Features.Enums.CommandType CommandType { get; }

		public bool CommandFound { get; }

		public global::CommandSystem.ICommand Command { get; set; }

		public global::System.ArraySegment<string> Arguments { get; set; }

		public string CommandName
		{
			get
			{
				string[] array = Arguments.Array;
				return ((array != null) ? array[0] : null) ?? string.Empty;
			}
		}

		public CommandExecutingEventArgs(CommandSender sender, global::LabApi.Features.Enums.CommandType commandType, bool wasFound, global::CommandSystem.ICommand command, global::System.ArraySegment<string> arguments)
		{
			IsAllowed = true;
			Sender = sender;
			CommandType = commandType;
			CommandFound = wasFound;
			Command = command;
			Arguments = arguments;
		}
	}
}
