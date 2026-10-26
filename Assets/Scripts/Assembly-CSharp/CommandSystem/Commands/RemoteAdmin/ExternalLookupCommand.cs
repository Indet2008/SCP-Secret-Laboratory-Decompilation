using System;
using System.Collections.Generic;
using MEC;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ExternalLookupCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "externallookup";

		public string[] Aliases { get; }

		public string Description { get; } = "Internal command for lookups in RA";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.BanningUpToDay | PlayerPermissions.LongTermBanning | PlayerPermissions.SetGroup | PlayerPermissions.PlayersManagement | PlayerPermissions.PermissionsManagement | PlayerPermissions.ViewHiddenBadges | PlayerPermissions.PlayerSensitiveDataAccess | PlayerPermissions.ViewHiddenGlobalBadges, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "This command can only be executed by players!";
				return false;
			}
			string text = string.Empty;
			if (arguments.Count >= 1)
			{
				if (!int.TryParse(arguments.At(0), out var result))
				{
					response = "Invalid player id!";
					return false;
				}
				if (!ReferenceHub.TryGetHub(result, out var hub))
				{
					response = "Invalid player id!";
					return false;
				}
				text = hub.authManager.UserId;
			}
			string remoteAdminExternalPlayerLookupMode = ServerConfigSynchronizer.Singleton.RemoteAdminExternalPlayerLookupMode;
			if (!(remoteAdminExternalPlayerLookupMode == "fullauth"))
			{
				if (remoteAdminExternalPlayerLookupMode == "urlonly")
				{
					playerCommandSender.RaReply("%" + text + "%" + ServerConfigSynchronizer.Singleton.RemoteAdminExternalPlayerLookupURL, success: true, logToConsole: false, "");
					response = "Lookup success!";
					return true;
				}
				response = "Invalid mode or command disabled via config.";
				return false;
			}
			Timing.RunCoroutine(AuthenticateWithExternalServer(playerCommandSender, text));
			response = "Initiated communication with external server.";
			return true;
		}

		private IEnumerator<float> AuthenticateWithExternalServer(PlayerCommandSender ply, string tolookup)
		{
			using HttpCoroutine http = HttpQuery.GetCoroutine(ServerConfigSynchronizer.Singleton.RemoteAdminExternalPlayerLookupURL + "?user-id=" + ply.ReferenceHub.authManager.UserId + "&user-ip=" + ply.ReferenceHub.characterClassManager.connectionToClient.address + "&token=" + ServerConfigSynchronizer.Singleton.RemoteAdminExternalPlayerLookupToken);
			yield return http.Wait();
			try
			{
				http.CheckResult();
				string text = http.GetText();
				if (!text.StartsWith("https://") && !text.StartsWith("http://"))
				{
					ServerConsole.AddLog("Error while performing external player lookup - URL Invalid.", ConsoleColor.Red);
					ply.RaReply("Error while processing reply from server - URL Invalid.", success: false, logToConsole: true, "");
					yield break;
				}
				if (text.Length > 2000)
				{
					ServerConsole.AddLog("Error while performing external player lookup - URL Too Long.", ConsoleColor.Red);
					ply.RaReply("Error while processing reply from server - URL Too Long.", success: false, logToConsole: true, "");
					yield break;
				}
				ply.RaReply("%" + tolookup + "%" + text, success: true, logToConsole: false, "");
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Error while performing external player lookup: " + ex.Message + ".", ConsoleColor.Red);
				ply.RaReply("Error while processing reply from server " + ex.Message + ".", success: false, logToConsole: true, "");
			}
		}
	}
}
