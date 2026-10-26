using CommandSystem.Commands.Console;
using CommandSystem.Commands.RemoteAdmin.Stripdown;
using CommandSystem.Commands.Shared;
using _Scripts.CommandSystem.Commands.Console;
using _Scripts.CommandSystem.Commands.Shared;

namespace CommandSystem
{
	public class GameConsoleCommandHandler : CommandHandler
	{
		private GameConsoleCommandHandler()
		{
		}

		public static GameConsoleCommandHandler Create()
		{
			GameConsoleCommandHandler gameConsoleCommandHandler = new GameConsoleCommandHandler();
			gameConsoleCommandHandler.LoadGeneratedCommands();
			return gameConsoleCommandHandler;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new QueryCommand());
			RegisterCommand(new BufferSizeCommand());
			RegisterCommand(new PrrCommand());
			RegisterCommand(new AudioPoolDebug());
			RegisterCommand(new BuildInfoCommand());
			RegisterCommand(ConfigCommand.Create());
			RegisterCommand(new EchoCommand());
			RegisterCommand(new ForceStartCommand());
			RegisterCommand(new HelloCommand());
			RegisterCommand(new HelpCommand(this));
			RegisterCommand(new NextRoundCommand());
			RegisterCommand(new NoopCommand());
			RegisterCommand(new PermCommand());
			RegisterCommand(new PlayersCommand());
			RegisterCommand(new QuitCommand());
			RegisterCommand(new RedirectCommand());
			RegisterCommand(new RefreshCommandsCommand(this));
			RegisterCommand(new RestartNextRoundCommand());
			RegisterCommand(new RidListCommand());
			RegisterCommand(new SoftRestartCommand());
			RegisterCommand(new StopNextRoundCommand());
			RegisterCommand(new SubscribeCommand());
			RegisterCommand(new UnsubscribeCommand());
			RegisterCommand(new UptimeRoundsCommand());
			RegisterCommand(StripdownCommand.Create());
			RegisterCommand(new AccuracyStatsCommand());
			RegisterCommand(new AnimCullingStatsCommand());
			RegisterCommand(new ArgsCommand());
			RegisterCommand(LineCommand.Create());
			RegisterCommand(new DisconnectCommand());
			RegisterCommand(new HttpInfoCommand());
			RegisterCommand(new IdCommand());
			RegisterCommand(new IdleCommand());
			RegisterCommand(new IpCommand());
			RegisterCommand(new ItemListCommand());
			RegisterCommand(new LennyCommand());
			RegisterCommand(new PauseCullingCommand());
			RegisterCommand(new ReloadTranslationsCommand());
			RegisterCommand(new RoleListCommand());
			RegisterCommand(new Scp1509ReceivedStatusCommand());
			RegisterCommand(new SeedCommand());
			RegisterCommand(new CommandSystem.Commands.Console.SrvCfgCommand());
			RegisterCommand(new PocketDimensionCommand());
			RegisterCommand(new RoundRestartCommand());
			RegisterCommand(new HostCommand());
		}
	}
}
