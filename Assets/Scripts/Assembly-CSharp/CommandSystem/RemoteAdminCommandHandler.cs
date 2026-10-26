using Christmas.Scp2536;
using CommandSystem.Commands;
using CommandSystem.Commands.Console;
using CommandSystem.Commands.RemoteAdmin;
using CommandSystem.Commands.RemoteAdmin.Broadcasts;
using CommandSystem.Commands.RemoteAdmin.Cleanup;
using CommandSystem.Commands.RemoteAdmin.Decontamination;
using CommandSystem.Commands.RemoteAdmin.Dms;
using CommandSystem.Commands.RemoteAdmin.Doors;
using CommandSystem.Commands.RemoteAdmin.Dummies;
using CommandSystem.Commands.RemoteAdmin.Inventory;
using CommandSystem.Commands.RemoteAdmin.MutingAndIntercom;
using CommandSystem.Commands.RemoteAdmin.ServerEvent;
using CommandSystem.Commands.RemoteAdmin.Stripdown;
using CommandSystem.Commands.RemoteAdmin.Warhead;
using CommandSystem.Commands.Shared;
using _Scripts.CommandSystem.Commands.Shared;

namespace CommandSystem
{
	public class RemoteAdminCommandHandler : CommandHandler
	{
		private RemoteAdminCommandHandler()
		{
		}

		public static RemoteAdminCommandHandler Create()
		{
			RemoteAdminCommandHandler remoteAdminCommandHandler = new RemoteAdminCommandHandler();
			remoteAdminCommandHandler.LoadGeneratedCommands();
			return remoteAdminCommandHandler;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new QueryCommand());
			RegisterCommand(new CassieClear());
			RegisterCommand(new AudioPoolDebug());
			RegisterCommand(new BuildInfoCommand());
			RegisterCommand(ConfigCommand.Create());
			RegisterCommand(new ContactCommand());
			RegisterCommand(new EchoCommand());
			RegisterCommand(new ForceStartCommand());
			RegisterCommand(new GlobalTagCommand());
			RegisterCommand(new HelloCommand());
			RegisterCommand(new HelpCommand(this));
			RegisterCommand(new HideTagCommand());
			RegisterCommand(new NextRoundCommand());
			RegisterCommand(new NoopCommand());
			RegisterCommand(new PermCommand());
			RegisterCommand(new PlayersCommand());
			RegisterCommand(new QuitCommand());
			RegisterCommand(new RedirectCommand());
			RegisterCommand(new RefreshCommandsCommand(this));
			RegisterCommand(new RestartNextRoundCommand());
			RegisterCommand(new RidListCommand());
			RegisterCommand(new ShowTagCommand());
			RegisterCommand(new SoftRestartCommand());
			RegisterCommand(new CommandSystem.Commands.Shared.SrvCfgCommand());
			RegisterCommand(new StopNextRoundCommand());
			RegisterCommand(new SubscribeCommand());
			RegisterCommand(new TpsCommand());
			RegisterCommand(new UnsubscribeCommand());
			RegisterCommand(new UptimeRoundsCommand());
			RegisterCommand(new BanCommand());
			RegisterCommand(new GbanKickCommand());
			RegisterCommand(new OfflineBanCommand());
			RegisterCommand(new UnbanCommand());
			RegisterCommand(new BringCommand());
			RegisterCommand(new BypassCommand());
			RegisterCommand(new CassieAdvancedCommand());
			RegisterCommand(new CassieCommand());
			RegisterCommand(new CassieSilentCommand());
			RegisterCommand(new CassieWordsCommand());
			RegisterCommand(new ChangeColorCommand());
			RegisterCommand(new ChangeCustomPlayerInfoCommand());
			RegisterCommand(new ChangeNameCommand());
			RegisterCommand(new ClearEffectsCommand());
			RegisterCommand(new DangerCommand());
			RegisterCommand(new DestroyToyCommand());
			RegisterCommand(new DisarmCommand());
			RegisterCommand(new DisplayNameCommand());
			RegisterCommand(new EffectCommand());
			RegisterCommand(ElevatorCommand.Create());
			RegisterCommand(new ExecuteAsCommand());
			RegisterCommand(new ExternalLookupCommand());
			RegisterCommand(new ForceAttachmentsCommand());
			RegisterCommand(new ForceRoleCommand());
			RegisterCommand(new FriendlyFireDetectorCommand());
			RegisterCommand(new GiveLoadoutCommand());
			RegisterCommand(new GodCommand());
			RegisterCommand(new GotoCommand());
			RegisterCommand(new HealCommand());
			RegisterCommand(new AddCandyCommand());
			RegisterCommand(new PlayerInventoryCommand());
			RegisterCommand(new StripCommand());
			RegisterCommand(new KeyCommand());
			RegisterCommand(new KillCommand());
			RegisterCommand(new LobbyLockCommand());
			RegisterCommand(new IntercomResetCommand());
			RegisterCommand(new IntercomSpeakCommand());
			RegisterCommand(new IntercomTimeoutCommand());
			RegisterCommand(new NoclipCommand());
			RegisterCommand(new OverchargeCommand());
			RegisterCommand(new OverwatchCommand());
			RegisterCommand(PermissionsManagementCommand.Create());
			RegisterCommand(new PingCommand());
			RegisterCommand(new PocketDimensionDebug());
			RegisterCommand(new RAConfigCommand());
			RegisterCommand(new RconCommand());
			RegisterCommand(new ReleaseCommand());
			RegisterCommand(new ReloadConfigCommand());
			RegisterCommand(WaveCommand.Create());
			RegisterCommand(new RoomTPCommand());
			RegisterCommand(new RoundLockCommand());
			RegisterCommand(new RoundTimeCommand());
			RegisterCommand(new ScaleCommand());
			RegisterCommand(new AddExperienceCommand());
			RegisterCommand(new SetExperienceCommand());
			RegisterCommand(new SetLevelCommand());
			RegisterCommand(new Scp3114HistoryCommand());
			RegisterCommand(new SetGravityCommand());
			RegisterCommand(new SetGroupCommand());
			RegisterCommand(new SetHealthCommand());
			RegisterCommand(new SetHiddenSpectatableCommand());
			RegisterCommand(new SetMaxHealthCommand());
			RegisterCommand(new SpawnToyCommand());
			RegisterCommand(new SSSExampleCommand());
			RegisterCommand(new StareCommand());
			RegisterCommand(new StateCommand());
			RegisterCommand(new VersionCommand());
			RegisterCommand(new VisualizeCollidersCommand());
			RegisterCommand(new WikiCommand());
			RegisterCommand(WarheadCommand.Create());
			RegisterCommand(StripdownCommand.Create());
			RegisterCommand(ServerEventCommand.Create());
			RegisterCommand(new IntercomMuteCommand());
			RegisterCommand(new IntercomTextCommand());
			RegisterCommand(new IntercomUnmuteCommand());
			RegisterCommand(new MuteCommand());
			RegisterCommand(new UnmuteCommand());
			RegisterCommand(new CustomKeycardCommand());
			RegisterCommand(new ForceEquipCommand());
			RegisterCommand(new GiveCommand());
			RegisterCommand(new RemoveItemCommand());
			RegisterCommand(DummiesCommand.Create());
			RegisterCommand(new CloseDoorCommand());
			RegisterCommand(new DestroyDoorCommand());
			RegisterCommand(new DoorsListCommand());
			RegisterCommand(new DoorTPCommand());
			RegisterCommand(new LockDoorCommand());
			RegisterCommand(new LockdownCommand());
			RegisterCommand(new OpenDoorCommand());
			RegisterCommand(new RepairDoorCommand());
			RegisterCommand(new UnlockDoorCommand());
			RegisterCommand(DmsCommand.Create());
			RegisterCommand(DecontaminationCommand.Create());
			RegisterCommand(CleanupCommand.Create());
			RegisterCommand(new BroadcastCommand());
			RegisterCommand(new ClearBroadcastCommand());
			RegisterCommand(new PlayerBroadcastCommand());
			RegisterCommand(LineCommand.Create());
			RegisterCommand(new PocketDimensionCommand());
			RegisterCommand(new CommandSystem.Commands.Console.RoundRestartCommand());
			RegisterCommand(new GiftCommand());
			RegisterCommand(new TeleportTreeCommand());
		}
	}
}
