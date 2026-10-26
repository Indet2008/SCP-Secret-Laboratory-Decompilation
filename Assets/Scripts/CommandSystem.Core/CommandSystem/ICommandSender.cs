namespace CommandSystem
{
	public interface ICommandSender
	{
		string LogName { get; }

		void Respond(string message, bool success = true);
	}
}
