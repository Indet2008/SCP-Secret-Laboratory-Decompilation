using CommandSystem.Commands.Dot.Overwatch;
using CommandSystem.Commands.Shared;

namespace CommandSystem
{
	public class ClientCommandHandler : CommandHandler
	{
		private ClientCommandHandler()
		{
		}

		public static ClientCommandHandler Create()
		{
			ClientCommandHandler clientCommandHandler = new ClientCommandHandler();
			clientCommandHandler.LoadGeneratedCommands();
			return clientCommandHandler;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new AudioPoolDebug());
			RegisterCommand(new ContactCommand());
			RegisterCommand(new EchoCommand());
			RegisterCommand(new GlobalTagCommand());
			RegisterCommand(new GroupsCommand());
			RegisterCommand(new HelloCommand());
			RegisterCommand(new HelpCommand(this));
			RegisterCommand(new HideTagCommand());
			RegisterCommand(new NoopCommand());
			RegisterCommand(new ShowTagCommand());
			RegisterCommand(new SrvCfgCommand());
			RegisterCommand(OverwatchCommand.Create());
		}
	}
}
