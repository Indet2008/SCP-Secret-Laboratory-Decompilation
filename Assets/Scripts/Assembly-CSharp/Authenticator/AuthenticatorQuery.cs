using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using CentralAuth;
using GameCore;
using NorthwoodLib;
using RoundRestarting;
using ServerOutput;

namespace Authenticator
{
	public static class AuthenticatorQuery
	{
		public static bool SendData(IEnumerable<string> data)
		{
			try
			{
				string text = HttpQuery.Post(CentralServer.MasterUrl + "v5/authenticator.php", HttpQuery.ToPostArgs(data), "application/x-www-form-urlencoded");
				return text.StartsWith("{\"") ? ProcessResponse(text) : ProcessLegacyResponse(text);
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Could not update server data on server list - (LOCAL EXCEPTION) " + ex.Message, ConsoleColor.DarkRed);
				return false;
			}
		}

		private static void SendContactAddress()
		{
			try
			{
				List<string> list = new List<string>
				{
					"ip=" + ServerConsole.Ip,
					$"port={ServerConsole.PortToReport}",
					"version=2",
					"address=" + StringUtils.Base64Encode(ConfigFile.ServerConfig.GetString("contact_email"))
				};
				if (!string.IsNullOrEmpty(ServerConsole.Password))
				{
					list.Add("passcode=" + ServerConsole.Password);
				}
				HttpQuery.Post(CentralServer.MasterUrl + "v5/contactaddress.php", HttpQuery.ToPostArgs(list), "application/x-www-form-urlencoded");
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Could not submit server contact info - (LOCAL EXCEPTION) " + ex.Message, ConsoleColor.DarkRed);
			}
		}

		private static bool ProcessResponse(string response)
		{
			try
			{
				AuthenticatorResponse authenticatorResponse = JsonSerialize.FromJson<AuthenticatorResponse>(response);
				if (!string.IsNullOrEmpty(authenticatorResponse.verificationChallenge) && !string.IsNullOrEmpty(authenticatorResponse.verificationResponse))
				{
					CustomLiteNetLib4MirrorTransport.VerificationChallenge = authenticatorResponse.verificationChallenge;
					CustomLiteNetLib4MirrorTransport.VerificationResponse = authenticatorResponse.verificationResponse;
					ServerConsole.AddLog("Verification challenge and response have been obtained.\nThe system will attempt to check your server shortly, please allow up to 5 minutes.", ConsoleColor.Green);
				}
				if (!authenticatorResponse.success)
				{
					ServerConsole.AddLog("Could not update server data on server list - " + authenticatorResponse.error, ConsoleColor.DarkRed);
					return false;
				}
				if (!string.IsNullOrEmpty(authenticatorResponse.token))
				{
					ServerConsole.AddLog("Received verification token from central server.");
					SaveNewToken(authenticatorResponse.token);
				}
				if (authenticatorResponse.actions != null && authenticatorResponse.actions.Length != 0)
				{
					string[] actions = authenticatorResponse.actions;
					foreach (string action in actions)
					{
						MainThreadDispatcher.Dispatch(() =>
						{
							HandleAction(action);
						});
					}
				}
				if (authenticatorResponse.messages != null && authenticatorResponse.messages.Length != 0)
				{
					string[] actions = authenticatorResponse.messages;
					foreach (string text in actions)
					{
						ServerConsole.AddLog("[MESSAGE FROM CENTRAL SERVER] " + text, ConsoleColor.Cyan);
					}
				}
				if (authenticatorResponse.authAccepted != null && authenticatorResponse.authAccepted.Length != 0)
				{
					string[] actions = authenticatorResponse.authAccepted;
					foreach (string text2 in actions)
					{
						ServerConsole.AddLog("Authentication token of player " + text2 + " has been confirmed by central server.");
					}
				}
				if (authenticatorResponse.authRejected != null && authenticatorResponse.authRejected.Length != 0)
				{
					foreach (ReferenceHub player in ReferenceHub.AllHubs)
					{
						PlayerAuthenticationManager pam = player.authManager;
						if (!authenticatorResponse.authRejected.All((AuthenticatiorAuthReject rj) => rj.Id != pam.UserId))
						{
							string reason = authenticatorResponse.authRejected.FirstOrDefault((AuthenticatiorAuthReject rj) => rj.Id == pam.UserId).Reason ?? "<ERROR>";
							ServerConsole.AddLog("Authentication token of player " + pam.UserId + " has been revoked by central server with reason: " + reason);
							MainThreadDispatcher.Dispatch(() =>
							{
								player.gameConsoleTransmission.SendToClient(reason, "red");
								ServerConsole.Disconnect(player.connectionToClient, reason);
							});
						}
					}
				}
				return authenticatorResponse.verified;
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Could not update server data on server list - (LOCAL EXCEPTION) " + ex.Message, ConsoleColor.DarkRed);
				return false;
			}
		}

		private static bool ProcessLegacyResponse(string response)
		{
			if (response == "YES")
			{
				return true;
			}
			if (response.StartsWith("New code generated:"))
			{
				CustomNetworkManager.IsVerified = true;
				string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/verkey.txt";
				try
				{
					File.Delete(path);
				}
				catch
				{
					ServerConsole.AddLog("New password could not be saved.", ConsoleColor.DarkRed);
				}
				try
				{
					StreamWriter streamWriter = new StreamWriter(path);
					string text = response.Remove(0, response.IndexOf(":", StringComparison.Ordinal)).Remove(response.IndexOf(":", StringComparison.Ordinal));
					while (text.Contains(":"))
					{
						text = text.Replace(":", string.Empty);
					}
					streamWriter.WriteLine(text);
					streamWriter.Close();
					ServerConsole.AddLog("New password saved.", ConsoleColor.DarkRed);
					ServerConsole.Update = true;
				}
				catch
				{
					ServerConsole.AddLog("New password could not be saved.", ConsoleColor.DarkRed);
				}
			}
			else if (response.Contains(":Restart:"))
			{
				HandleAction("Restart");
			}
			else if (response.Contains(":RoundRestart:"))
			{
				HandleAction("RoundRestart");
			}
			else if (response.Contains(":UpdateData:"))
			{
				HandleAction("UpdateData");
			}
			else if (response.Contains(":RefreshKey:"))
			{
				HandleAction("RefreshKey");
			}
			else if (response.Contains(":Message - "))
			{
				string text2 = response.Substring(response.IndexOf(":Message - ", StringComparison.Ordinal) + 11);
				text2 = text2.Substring(0, text2.IndexOf(":::", StringComparison.Ordinal));
				ServerConsole.AddLog("[MESSAGE FROM CENTRAL SERVER] " + text2, ConsoleColor.Cyan);
			}
			else if (response.Contains(":GetContactAddress:"))
			{
				HandleAction("GetContactAddress");
			}
			else
			{
				if (response.Contains("Server is not verified."))
				{
					return false;
				}
				ServerConsole.AddLog("Could not update data on server list (legacy)- " + response, ConsoleColor.DarkRed);
			}
			return true;
		}

		internal static void HandleAction(string action)
		{
			switch (action)
			{
			case "Restart":
				ServerConsole.AddOutputEntry(default(ExitActionRestartEntry));
				ServerConsole.AddLog("Server restart requested by central server.", ConsoleColor.DarkRed);
				Shutdown.Quit();
				break;
			case "RoundRestart":
			{
				ServerConsole.AddLog("Round restart requested by central server.", ConsoleColor.DarkRed);
				if (ReferenceHub.TryGetLocalHub(out var hub) && hub.networkIdentity.isServer)
				{
					RoundRestart.InitiateRoundRestart();
				}
				break;
			}
			case "UpdateData":
				ServerConsole.Update = true;
				break;
			case "RefreshKey":
				ServerConsole.RunRefreshPublicKeyOnce();
				break;
			case "GetContactAddress":
			{
				Thread thread = new Thread(SendContactAddress);
				thread.Name = "SCP:SL Response to central servers (contact data request)";
				thread.Priority = ThreadPriority.BelowNormal;
				thread.IsBackground = true;
				thread.Start();
				break;
			}
			}
		}

		private static void SaveNewToken(string token)
		{
			CustomNetworkManager.IsVerified = true;
			string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/verkey.txt";
			try
			{
				File.Delete(path);
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("New verification token could not be saved (1): " + ex.Message, ConsoleColor.DarkRed);
			}
			try
			{
				StreamWriter streamWriter = new StreamWriter(path);
				streamWriter.WriteLine(token);
				streamWriter.Close();
				ServerConsole.AddLog("New verification token saved.", ConsoleColor.DarkRed);
				ServerConsole.Update = true;
				ServerConsole.ScheduleTokenRefresh = true;
			}
			catch (Exception ex2)
			{
				ServerConsole.AddLog("New verification token could not be saved (2): " + ex2.Message, ConsoleColor.DarkRed);
			}
		}
	}
}
