using System;
using System.Globalization;
using CustomPlayerEffects;
using Utils;
using Utils.CommandInterpolation;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RAConfigCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "setconfig";

		public string[] Aliases { get; } = new string[1] { "sc" };

		public string Description { get; } = "Sets the server configuration.";

		public string[] Usage { get; } = new string[2] { "Option", "Value" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			if (arguments.Count >= 2)
			{
				string text = RAUtils.FormatArguments(arguments, 1).Trim();
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " changed server configuration: " + arguments.At(0) + ": " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				switch (arguments.At(0).ToUpper())
				{
				case "FRIENDLY_FIRE":
				{
					if (bool.TryParse(text, out var result4))
					{
						ServerConsole.FriendlyFire = result4;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{result4}]!";
						ServerConfigSynchronizer.RefreshAllConfigs();
						return true;
					}
					if (text.Equals("toggle", StringComparison.OrdinalIgnoreCase))
					{
						ServerConsole.FriendlyFire = !ServerConsole.FriendlyFire;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{ServerConsole.FriendlyFire}]!";
						ServerConfigSynchronizer.RefreshAllConfigs();
						return true;
					}
					response = arguments.At(0) + " has invalid value, " + text + " is not a valid bool!";
					return false;
				}
				case "PLAYER_LIST_TITLE":
				{
					string text2 = text ?? string.Empty;
					PlayerList.Title.Value = text2;
					try
					{
						PlayerList.singleton.RefreshTitle();
					}
					catch (Exception ex)
					{
						if (!(ex is CommandInputException) && !(ex is InvalidOperationException))
						{
							throw;
						}
						response = "Could not set player list title [" + text2 + "]:\n" + ex.Message;
						return false;
					}
					response = "Done! Config [" + arguments.At(0) + "] has been set to [" + ServerConfigSynchronizer.Singleton.ServerName + "]!";
					ServerConfigSynchronizer.RefreshAllConfigs();
					return true;
				}
				case "PD_REFRESH_EXIT":
				{
					if (bool.TryParse(text, out var result2))
					{
						PocketDimensionTeleport.RefreshExit = result2;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{result2}]!";
						ServerConfigSynchronizer.RefreshAllConfigs();
						return true;
					}
					response = arguments.At(0) + " has invalid value, " + text + " is not a valid bool!";
					return false;
				}
				case "SPAWN_PROTECT_ENABLED":
				{
					if (bool.TryParse(text, out var result3))
					{
						SpawnProtected.IsProtectionEnabled = result3;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{result3}]!";
						return true;
					}
					if (text.Equals("toggle", StringComparison.OrdinalIgnoreCase))
					{
						SpawnProtected.IsProtectionEnabled = !SpawnProtected.IsProtectionEnabled;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{SpawnProtected.IsProtectionEnabled}]!";
						return true;
					}
					response = arguments.At(0) + " has invalid value, " + text + " is not a valid bool!";
					return false;
				}
				case "SPAWN_PROTECT_TIME":
				{
					if (int.TryParse(text, NumberStyles.Any, CultureInfo.InvariantCulture, out var result))
					{
						SpawnProtected.SpawnDuration = result;
						response = $"Done! Config [{arguments.At(0)}] has been set to [{result}]!";
						ServerConfigSynchronizer.RefreshAllConfigs();
						return true;
					}
					response = arguments.At(0) + " has invalid value, " + text + " is not a valid integer!";
					return false;
				}
				default:
					response = "Invalid config " + arguments.At(0);
					return false;
				}
			}
			response = "To execute this command provide at least 2 arguments!";
			return false;
		}
	}
}
