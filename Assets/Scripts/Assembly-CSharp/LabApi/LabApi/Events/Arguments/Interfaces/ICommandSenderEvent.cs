namespace LabApi.Events.Arguments.Interfaces
{
	public interface ICommandSenderEvent
	{
		CommandSender? Sender { get; }
	}
}
