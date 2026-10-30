using System;
using System.Linq;
using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public class RaGlobalBan : IServerCommunication, IClientCommunication
	{
		public int DataId => 5;

		public void ReceiveData(CommandSender sender, string data)
		{
			string[] array = data.Split(' ');
			if (array.Length < 2 || !int.TryParse(array[0], out var result))
			{
				return;
			}
			bool flag = result == 1;
			data = string.Join(" ", array.Skip(1));
			if (!(sender is PlayerCommandSender playerCommandSender) || !playerCommandSender.ReferenceHub.authManager.RemoteAdminGlobalAccess)
			{
				return;
			}
			ReferenceHub referenceHub = null;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((flag && allHub.PlayerId.ToString() == data) || (!flag && string.Equals(allHub.nicknameSync.MyNick, data, StringComparison.OrdinalIgnoreCase)))
				{
					referenceHub = allHub;
					break;
				}
			}
			if (referenceHub == null || referenceHub.authManager.AuthenticationResponse.SignedAuthToken == null)
			{
				sender.RaReply($"${DataId} 0", success: true, logToConsole: false, string.Empty);
			}
			else
			{
				sender.RaReply($"${DataId} 1 {referenceHub.authManager.GetAuthToken()}", success: true, logToConsole: false, string.Empty);
			}
		}

		private static string _toBan;

		private static string _toBanUserId;

		private static string _toBanAuth;

		public static void Request(string key, int keytype)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((keytype == 1 && allHub.PlayerId.ToString() == key) || (keytype != 1 && string.Equals(allHub.nicknameSync.MyNick, key, StringComparison.OrdinalIgnoreCase)))
				{
					ReferenceHub.LocalHub.queryProcessor.SendQuery(string.Format("$5 {0} {1}", keytype, key));
					return;
				}
			}
			GameCore.Console.AddLog("Requested player can't be found (client-side)!", UnityEngine.Color.red);
		}

		public void ReceiveData(string data, bool secure)
		{
			if (data.Length == 0)
			{
				return;
			}
			switch (data[0])
			{
			case '0':
				GameCore.Console.AddLog("Requested player can't be found!", UnityEngine.Color.red);
				break;
			case '1':
			{
				if (data.Length < 3)
				{
					GameCore.Console.AddLog("Requested player can't be found!", UnityEngine.Color.red);
					break;
				}
				string text = data.Substring(2);
				if (!JsonSerialize.FromJson<SignedToken>(text).TryGetToken<AuthenticationToken>("Authentication", out var token, out var error, out var userId, 60))
				{
					GameCore.Console.AddLog("Can't validate auth token. Error: " + error, UnityEngine.Color.red);
					break;
				}
				_toBan = NorthwoodLib.StringUtils.Base64Decode(token.Nickname);
				_toBanUserId = userId;
				_toBanAuth = text;
				GameCore.Console.AddLog("==== GLOBAL BANNING FINAL STEP ====", UnityEngine.Color.red);
				GameCore.Console.AddLog(secure ? "Token obtained over encrypted connection." : "Token obtained over **UNENCRYPTED** connection.", secure ? UnityEngine.Color.green : UnityEngine.Color.red);
				GameCore.Console.AddLog("Nick: " + _toBan, UnityEngine.Color.red);
				GameCore.Console.AddLog("User ID: " + _toBanUserId, UnityEngine.Color.red);
				GameCore.Console.AddLog("ID on this server: " + token.PlayerId, UnityEngine.Color.red);
				GameCore.Console.AddLog(string.Empty, UnityEngine.Color.red);
				GameCore.Console.AddLog("To confirm ban please execute \"CONFIRM\" command.", UnityEngine.Color.red);
				break;
			}
			default:
				GameCore.Console.AddLog(string.Format("Recevied global ban response but type {0}!", data[0]), UnityEngine.Color.red);
				break;
			}
		}

		internal static void ConfirmGlobalBanning()
		{
			if (_toBan == null)
			{
				GameCore.Console.AddLog("You don't have any pending global ban request to confirm.", UnityEngine.Color.red);
			}
			else
			{
				MEC.Timing.RunCoroutine(IssueGlobalBan());
			}
		}

		private static System.Collections.Generic.IEnumerator<float> IssueGlobalBan()
		{
			GameCore.Console.AddLog("Issuing global ban for " + _toBan, UnityEngine.Color.red);
			string text;
			using (System.IO.StreamReader streamReader = new System.IO.StreamReader(FileManager.GetAppFolder() + "StaffAPI.txt", System.Text.Encoding.UTF8))
			{
				text = streamReader.ReadToEnd().Trim();
			}
			string data = string.Join("&", new string[4]
			{
				"token=" + text,
				"action=ban",
				"userid=" + NorthwoodLib.StringUtils.Base64Encode(_toBanUserId),
				"auth=" + NorthwoodLib.StringUtils.Base64Encode(_toBanAuth)
			});
			using HttpCoroutine request = HttpQuery.PostCoroutine(CentralServer.StandardUrl + "v5/globalbanning.php?version=2", data, "application/x-www-form-urlencoded");
			yield return request.Wait();
			try
			{
				request.CheckResult();
				GlobalBanningResponse globalBanningResponse = JsonSerialize.FromJson<GlobalBanningResponse>(request.GetText());
				if (globalBanningResponse.Success)
				{
					GameCore.Console.AddLog("==== GLOBAL BANNING CONFIRMATION ====", UnityEngine.Color.red);
					GameCore.Console.AddLog("User ID: " + _toBanUserId, UnityEngine.Color.red);
					GameCore.Console.AddLog("Player has been globally banned.", UnityEngine.Color.red);
					GameCore.Console.AddLog("Global ban issued, kicking player from server...", UnityEngine.Color.red);
					ReferenceHub.LocalHub.queryProcessor.SendQuery("GBAN-KICK " + _toBanUserId, gban: true);
					GameCore.Console.AddLog("Request to kick this player has been sent to game server.", UnityEngine.Color.red);
				}
				else
				{
					GameCore.Console.AddLog("Server error during global ban issuance: " + globalBanningResponse.Message, UnityEngine.Color.red);
				}
			}
			finally
			{
				_toBan = null;
				_toBanUserId = null;
				_toBanAuth = null;
			}
		}
	}
}
