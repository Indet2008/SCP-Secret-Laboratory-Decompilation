namespace LabApi.Events.Arguments.ServerEvents
{
	public class SentAdminChatEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICommandSenderEvent
	{
		public string Message { get; }

		public CommandSender Sender { get; }

		public SentAdminChatEventArgs(CommandSender sender, string message)
		{
			Sender = sender;
			Message = message;
		}
	}
}
