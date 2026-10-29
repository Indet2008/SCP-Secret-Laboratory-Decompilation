namespace LabApi.Events.Arguments.ServerEvents
{
	public class SendingAdminChatEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICommandSenderEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public string Message { get; set; }

		public CommandSender Sender { get; }

		public bool IsAllowed { get; set; }

		public SendingAdminChatEventArgs(CommandSender sender, string message)
		{
			IsAllowed = true;
			Sender = sender;
			Message = message;
		}
	}
}
