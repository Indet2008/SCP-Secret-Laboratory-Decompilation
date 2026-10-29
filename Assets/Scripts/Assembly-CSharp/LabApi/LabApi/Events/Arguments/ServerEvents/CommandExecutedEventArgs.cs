namespace LabApi.Events.Arguments.ServerEvents
{
	public class CommandExecutedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICommandSenderEvent
	{
		public CommandSender? Sender { get; }

		public global::LabApi.Features.Enums.CommandType CommandType { get; }

		public global::CommandSystem.ICommand Command { get; }

		public global::System.ArraySegment<string> Arguments { get; }

		public bool ExecutedSuccessfully { get; set; }

		public string Response { get; set; }

		public string CommandName
		{
			get
			{
				string[] array = Arguments.Array;
				return ((array != null) ? array[0] : null) ?? string.Empty;
			}
		}

		public CommandExecutedEventArgs(CommandSender? sender, global::LabApi.Features.Enums.CommandType commandType, global::CommandSystem.ICommand command, global::System.ArraySegment<string> arguments, bool successful, string response)
		{
			Sender = sender;
			CommandType = commandType;
			Command = command;
			Arguments = arguments;
			ExecutedSuccessfully = successful;
			Response = response;
		}
	}
}
