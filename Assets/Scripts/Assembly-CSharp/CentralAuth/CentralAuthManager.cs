using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;
using Cryptography;
using GameCore;
using Mirror;
using NorthwoodLib;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Security;
using UnityEngine;
using Utf8Json;

namespace CentralAuth
{
	public static class CentralAuthManager
	{
		private static bool _initialized;

		private static bool _authDebugEnabled;

		public const int TokenVersion = 2;

		private static readonly Regex _challengeRegex = new Regex("^[a-zA-Z0-9]{24}$", RegexOptions.Compiled);

		private static readonly Stopwatch _timeCounter = new Stopwatch();

		private static bool _interacted;

		internal static string TokenChallenge;

		internal static string ServerEcdhPublicKey;

		internal static bool ForceRenew;

		internal static bool RequestAuthToken;

		internal static string ApiToken = string.Empty;

		internal static string Nonce = string.Empty;

		internal static bool NoWatermarking;

		internal static AuthStatusType AuthStatusType = AuthStatusType.Connecting;

		private static ushort _lifetime;

		private static bool _abort;

		private static Thread _authThread;

		private static string DiscordOAuth2Token;

		private const string SteamStartupArg = "-steam";

		private const string SteamDistributionStartupArg = "-distrib-steam";

		private const string DiscordStartupArg = "-discord";

		private const string ForceDiscordStartupArg = "-fdiscord";

		private const string NoAuthStartupArg = "-noauth";

		private const string AuthDebugArg = "-authdebug";

		private const string AuthDebugFileName = "EnableDebug.txt";

		public static DistributionPlatform Platform { get; private set; }

		internal static int CurrentPlayerId { get; set; }

		internal static bool Authenticated { get; private set; }

		internal static string GlobalBanReason { get; private set; }

		internal static CentralAuthPreauthToken PreauthToken { get; private set; }

		internal static string DiscordState { get; private set; } = "Not initialized!";

		internal static global::Discord.Discord Discord { get; private set; }

		internal static AsymmetricCipherKeyPair SessionKeys { get; private set; }

		private static void Authenticate()
		{
			if (_authThread != null)
			{
				return;
			}
			// Not in the original: the auth ticket is signed by the official launcher (SL-AC). Without it the central
			// server always rejects the session, so skip authentication instead of retrying forever.
			if (!LauncherCommunicator.Available)
			{
				AuthStatusType = AuthStatusType.PlatformAuthFailure;
				GameCore.Console.AddLog("Central server authentication skipped: the game was not started through the official launcher (no ticket signer). Online-mode servers will reject this client.", Color.yellow, nospace: true);
				return;
			}
			if (StartupArgs.Args.Any((string arg) => string.Equals(arg, "-authdebug", StringComparison.OrdinalIgnoreCase)) || File.Exists(FileManager.GetAppFolder(addSeparator: true) + "EnableDebug.txt"))
			{
				_authDebugEnabled = true;
				GameCore.Console.AddLog("Auth debug enabled.", Color.gray, nospace: true);
			}
			_authThread = new Thread(Authentication)
			{
				Priority = System.Threading.ThreadPriority.Normal,
				IsBackground = true,
				Name = "Authentication Thread"
			};
			_authThread.Start();
		}

		internal static void Abort()
		{
			if (!_abort && _authThread != null && _authThread.IsAlive)
			{
				UnityEngine.Debug.Log("Stopping authentication thread...");
				_abort = true;
			}
		}

		private static void AuthDebug(string msg)
		{
			GameCore.Console.AddDebugLog("SDAUTH", msg, MessageImportance.LeastImportant);
		}

		private static void AuthDebug(string msg, Color color)
		{
			GameCore.Console.AddDebugLog("SDAUTH", "<color=" + color.ToHex() + ">" + msg + "</color>", MessageImportance.LeastImportant);
		}

		private static void Authentication()
		{
			AuthDebug("Started authentication thread.", Color.gray);
			Authenticated = false;
			while (!CentralServer.ServerSelected)
			{
				Thread.Sleep(25);
			}
			AuthDebug("Authentication initialized.", Color.gray);
			List<string> list = new List<string>();
			int num = 0;
			while (true)
			{
				num++;
				byte b = 0;
				while (true)
				{
					string text = string.Empty;
					if (Platform == DistributionPlatform.Steam)
					{
						if (!SteamManager.Running)
						{
							AuthStatusType = AuthStatusType.PlatformAuthFailure;
							GameCore.Console.AddLog("Steam not initialized.\nIf server is using online mode, you will probably get kicked.", Color.red, nospace: true);
							return;
						}
						AuthDebug("Revoking previous Steam authentication ticket...", Color.gray);
						SteamManager.CancelTicket();
						AuthDebug("Obtaining authentication ticket from Steam...", Color.gray);
						Steamworks.AuthTicket authSessionTicket = SteamManager.GetAuthSessionTicket();
						if (authSessionTicket?.Data == null || authSessionTicket.Data.Length == 0)
						{
							AuthDebug("Steam returned invalid auth ticket, Retrying.", Color.yellow);
							Thread.Sleep(1000);
							continue;
						}
						text = BitConverter.ToString(authSessionTicket.Data, 0, authSessionTicket.Data.Length).Replace("-", string.Empty);
						AuthDebug("Authentication Ticked obtained from Steam.", Color.green);
					}
					else
					{
						if (Platform != DistributionPlatform.Discord)
						{
							GameCore.Console.AddDebugLog("SDAUTH", "Dedicated server mode - obtaining auth ticket skipped", MessageImportance.LeastImportant);
							return;
						}
						if (DiscordOAuth2Token == null)
						{
							AuthStatusType = AuthStatusType.PlatformAuthFailure;
							GameCore.Console.AddLog("Couldn't auth with Discord.\nIf server is using online mode, you will probably get kicked.", Color.red, nospace: true);
							return;
						}
						text = DiscordOAuth2Token;
					}
					string text2 = Sign(text);
					GameCore.Console.AddDebugLog("SDAUTH", string.Format("Establishing authentication session (attempt {0})...", num), MessageImportance.LeastImportant);
					string text3 = ((Platform == DistributionPlatform.Discord) ? "v5/discord/authenticate.php" : "v5/steam/authenticate.php");
					list.Clear();
					list.AddRange(new string[5]
					{
						"ticket=" + text,
						"publickey=" + Sha.HashToString(Sha.Sha256(ECDSA.KeyToString(SessionKeys.Public))),
						"signature=" + text2,
						"gameVersion=" + StringUtils.Base64Encode(GameCore.Version.VersionString),
						"version=2"
					});
					AddPrivacyArgs(list);
					try
					{
						string text4 = HttpQuery.Post(CentralServer.StandardUrl + text3, HttpQuery.ToPostArgs(list), "application/x-www-form-urlencoded");
						AuthDebug("[AUTH] " + text4, Color.gray);
						try
						{
							AuthenticateResponse authenticateResponse = JsonSerialize.FromJson<AuthenticateResponse>(text4);
							if (authenticateResponse.success)
							{
								ApiToken = authenticateResponse.token;
								Nonce = authenticateResponse.nonce;
								_lifetime = authenticateResponse.lifetime;
								GlobalBanReason = authenticateResponse.globalBan;
								PreauthToken = new CentralAuthPreauthToken(authenticateResponse.id, authenticateResponse.flags, authenticateResponse.country, authenticateResponse.expiration, authenticateResponse.preauth);
								if ((authenticateResponse.flags & 0x20) != 0)
								{
									GameCore.Console.DisplayCreateServer = true;
								}
								NoWatermarking = authenticateResponse.NoWatermarking;
								Authenticated = true;
								AuthDebug("Authentication session established.", Color.green);
								AuthStatusType = AuthStatusType.Success;
							}
							else
							{
								Authenticated = false;
								UnityEngine.Debug.LogError("Authentication error (authenticate - response): " + authenticateResponse.error);
								AuthDebug("Authentication error (authenticate - response): " + authenticateResponse.error, Color.red);
							}
						}
						catch (Exception ex)
						{
							Authenticated = false;
							UnityEngine.Debug.LogError("Authentication error (authenticate - inner web): " + ex.Message);
							UnityEngine.Debug.LogError("[AUTH] " + text4);
							UnityEngine.Debug.LogError("Signature1: " + text2);
							AuthDebug("Authentication error (authenticate - inner web): " + ex.Message, Color.red);
							AuthDebug("[AUTH] " + text4, Color.red);
							AuthDebug("Signature1: " + text2, Color.red);
						}
					}
					catch (WebException ex2)
					{
						Authenticated = false;
						UnityEngine.Debug.LogError("Authentication error (authenticate - web): " + ex2.Message);
						AuthDebug("Authentication error (authenticate - web): " + ex2.Message, Color.red);
					}
					catch (Exception ex3)
					{
						Authenticated = false;
						UnityEngine.Debug.LogError("Authentication error (authenticate): " + ex3.Message);
						UnityEngine.Debug.LogError(ex3.StackTrace);
						AuthDebug("Authentication error (authenticate): " + ex3.Message, Color.red);
						AuthDebug(ex3.StackTrace, Color.red);
					}
					if (_abort)
					{
						return;
					}
					if (Authenticated)
					{
						break;
					}
					AuthStatusType = AuthStatusType.Failure;
					b++;
					if (b == 1)
					{
						Thread.Sleep(4000);
						continue;
					}
					if (b == 2)
					{
						CentralServer.ChangeCentralServer(remove: true);
						Thread.Sleep(5000);
						continue;
					}
					Thread.Sleep(10000);
					b = 0;
					num++;
				}
				while (Authenticated)
				{
					list.Clear();
					ForceRenew = false;
					for (ushort num2 = 0; num2 < _lifetime * 5; num2++)
					{
						if (ForceRenew)
						{
							break;
						}
						if (_abort)
						{
							return;
						}
						if (RequestAuthToken)
						{
							RequestAuthToken = false;
							RequestToken();
						}
						else
						{
							Thread.Sleep(200);
						}
					}
					AuthDebug("Renewing authentication session...", Color.gray);
					list.Clear();
					list.Add("token=" + ApiToken);
					list.Add("nonce=" + Nonce);
					list.Add("gameVersion=" + StringUtils.Base64Encode(GameCore.Version.VersionString));
					AddPrivacyArgs(list);
					try
					{
						string text5 = HttpQuery.Post(CentralServer.StandardUrl + "v5/renew.php", HttpQuery.ToPostArgs(list), "application/x-www-form-urlencoded");
						AuthDebug("[RENEWAL] " + text5, Color.gray);
						try
						{
							RenewResponse renewResponse = JsonSerialize.FromJson<RenewResponse>(text5);
							if (renewResponse.success)
							{
								Authenticated = true;
								Nonce = renewResponse.nonce;
								_lifetime = renewResponse.lifetime;
								GlobalBanReason = renewResponse.globalBan;
								PreauthToken = new CentralAuthPreauthToken(renewResponse.id, renewResponse.flags, renewResponse.country, renewResponse.expiration, renewResponse.preauth);
								if ((renewResponse.flags & 0x20) != 0)
								{
									GameCore.Console.DisplayCreateServer = true;
								}
								AuthDebug("Authentication session renewed.", Color.green);
								AuthStatusType = AuthStatusType.Success;
							}
							else
							{
								Authenticated = false;
								UnityEngine.Debug.LogError("Authentication error (renewal - response): " + renewResponse.error);
								AuthDebug("Authentication error (renewal - response): " + renewResponse.error, Color.red);
							}
						}
						catch (Exception ex4)
						{
							Authenticated = false;
							UnityEngine.Debug.LogError("Authentication error (renewal - inner web): " + ex4.Message);
							UnityEngine.Debug.LogError("[RENEWAL] " + text5);
							AuthDebug("Authentication error (renewal - inner web): " + ex4.Message, Color.red);
							AuthDebug("[RENEWAL] " + text5, Color.red);
						}
					}
					catch (WebException ex5)
					{
						Authenticated = false;
						UnityEngine.Debug.LogError("Authentication error (renewal - web): " + ex5.Message);
						AuthDebug("Authentication error (renewal - web): " + ex5.Message, Color.red);
					}
					catch (Exception ex6)
					{
						Authenticated = false;
						UnityEngine.Debug.LogError("Authentication error (renewal): " + ex6.Message);
						UnityEngine.Debug.LogError(ex6.StackTrace);
						AuthDebug("Authentication error (renewal): " + ex6.Message, Color.red);
						AuthDebug(ex6.StackTrace, Color.red);
					}
					list.Clear();
				}
				AuthStatusType = AuthStatusType.Failure;
				Thread.Sleep(500);
			}
		}

		private static void AddPrivacyArgs(List<string> list)
		{
			if (GameCore.Console.RequestDNT || UserSettings.UserSetting<bool>.Get(UserSettings.OtherSettings.MiscPrivacySetting.DoNotTrack))
			{
				list.Add("DNT=true");
			}
			if (!UserSettings.UserSetting<bool>.Get(UserSettings.OtherSettings.MiscPrivacySetting.HideSteamProfile))
			{
				list.Add("DisplayProfile=true");
			}
			if (GameCore.Version.PrivateBeta)
			{
				list.Add("privatebeta=true");
			}
		}

		private static void RequestToken()
		{
			if (Platform == DistributionPlatform.Dedicated)
			{
				UnityEngine.Debug.LogError("RequestToken called on dedicated server!");
				return;
			}
			AuthDebug("Requesting signature from central servers...");
			FastRoundRestartController.FastRestartInProgress = false;
			List<string> list = new List<string>
			{
				"playerid=" + CurrentPlayerId,
				"token=" + ApiToken,
				"nonce=" + Nonce,
				"signature=" + Sign(Nonce),
				"gameVersion=" + StringUtils.Base64Encode(GameCore.Version.VersionString),
				"format=json"
			};
			if (TokenChallenge != null)
			{
				if (!_challengeRegex.IsMatch(TokenChallenge))
				{
					AuthDebug("Authentication error: Challenge sent by game server is INVALID: " + TokenChallenge, Color.red);
					TokenChallenge = null;
				}
				else
				{
					list.Add("Challenge=" + TokenChallenge);
				}
			}
			AddPrivacyArgs(list);
			try
			{
				string text = HttpQuery.Post(CentralServer.StandardUrl + "v5/requestsignature.php", HttpQuery.ToPostArgs(list), "application/x-www-form-urlencoded");
				AuthDebug("Signature obtained from central servers", Color.green);
				RequestSignatureResponse requestSignatureResponse = JsonSerialize.FromJson<RequestSignatureResponse>(text);
				if (requestSignatureResponse.success)
				{
					Authenticated = true;
					Nonce = requestSignatureResponse.nonce;
					TokenChallenge = null;
					AuthDebug("Authentication token obtained.", Color.green);
					if (_authDebugEnabled)
					{
						string text2 = text;
						while (text2.Length > 0)
						{
							if (text2.Length <= 500)
							{
								AuthDebug("[AUTH DEBUG] " + text2);
								break;
							}
							AuthDebug("[AUTH DEBUG] " + text2.Substring(0, 500));
							text2 = text2.Substring(500, text2.Length - 500);
						}
						DebugToken(requestSignatureResponse.authToken, "RQST", "Authentication");
						DebugToken(requestSignatureResponse.badgeToken, "BADGE", "Badge request");
					}
					if (!NetworkClient.active || !NetworkClient.isConnected)
					{
						AuthDebug("Request signature called without active NetworkClient.", Color.red);
					}
					else
					{
						bool doNotTrack = GameCore.Console.RequestDNT || UserSettings.UserSetting<bool>.Get(UserSettings.OtherSettings.MiscPrivacySetting.DoNotTrack);
						bool hideBadge = UserSettings.UserSetting<int>.Get(UserSettings.OtherSettings.MiscPrivacySetting.BadgePreferences) == 2;
						AuthenticationResponse msg;
						if (ServerEcdhPublicKey == null)
						{
							msg = new AuthenticationResponse(requestSignatureResponse.authToken, requestSignatureResponse.badgeToken, SessionKeys.Public, null, null, doNotTrack, hideBadge);
						}
						else
						{
							EncryptedChannelManager.ClientProcessExchange(ServerEcdhPublicKey, out var clientPublicKey, out var signature);
							msg = new AuthenticationResponse(requestSignatureResponse.authToken, requestSignatureResponse.badgeToken, SessionKeys.Public, ECDSA.KeyToString(clientPublicKey), signature, doNotTrack, hideBadge);
						}
						MainThreadDispatcher.Dispatch(delegate
						{
							FinalizeServerAuthentication(msg);
						});
					}
					ServerEcdhPublicKey = null;
				}
				else
				{
					ForceRenew = true;
					RequestAuthToken = true;
					UnityEngine.Debug.LogError("Authentication error (rqstsgn - response): " + requestSignatureResponse.error);
					AuthDebug("Authentication error (rqstsgn - response): " + requestSignatureResponse.error, Color.red);
				}
			}
			catch (WebException ex)
			{
				UnityEngine.Debug.LogError("Authentication error (rqstsgn - web): " + ex.Message);
				AuthDebug("Authentication error (rqstsgn - web): " + ex.Message, Color.red);
				ForceRenew = true;
				RequestAuthToken = true;
			}
			catch (Exception ex2)
			{
				UnityEngine.Debug.LogError("Authentication error (rqstsgn): " + ex2.Message);
				UnityEngine.Debug.LogError(ex2.StackTrace);
				AuthDebug("Authentication error (rqstsgn): " + ex2.Message, Color.red);
				AuthDebug(ex2.StackTrace, Color.red);
				ForceRenew = true;
				RequestAuthToken = true;
			}
		}

		private static void DebugToken(SignedToken token, string tag, string requester)
		{
			if (token == null)
			{
				AuthDebug("[AUTH DEBUG - " + tag + "] (NULL)", Color.yellow);
				return;
			}
			AuthDebug("[AUTH DEBUG - " + tag + "] " + StringUtils.Base64Decode(token.token), Color.yellow);
			if (tag == "RQST")
			{
				if (token.TryGetToken<AuthenticationToken>(requester, out var _, out var error, out var _))
				{
					AuthDebug("[AUTH DEBUG - RQST] Token Valid", Color.green);
				}
				else
				{
					AuthDebug("[AUTH DEBUG - RQST] TOKEN INVALID: " + error, Color.red);
				}
			}
			else if (token.TryGetToken<BadgeToken>(requester, out var _, out var error2, out var _))
			{
				AuthDebug("[AUTH DEBUG - BADGE] Token Valid", Color.green);
			}
			else
			{
				AuthDebug("[AUTH DEBUG - BADGE] TOKEN INVALID: " + error2, Color.red);
			}
		}

		private static string Sign(string ticket)
		{
			AuthDebug("Signing auth ticket...");
			try
			{
				string result = Convert.ToBase64String(LauncherCommunicator.Send(ticket)).Replace('+', '!').Replace('/', '.').Replace('=', '-');
				AuthDebug("Auth ticket signed!", Color.green);
				return result;
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.Log("[Launcher Debug] Catch");
				UnityEngine.Debug.LogError("Laucher signer error");
				UnityEngine.Debug.LogError("ERROR: " + ex.Message);
				UnityEngine.Debug.LogError(ex.Message);
				return null;
			}
		}

		internal static void InitAuth()
		{
			if (_initialized)
			{
				return;
			}
			_initialized = true;
			CentralServer.Init();
			GameCore.Console.AddLog("Generating session keys...", Color.gray, nospace: true);
			ECKeyPairGenerator eCKeyPairGenerator = new ECKeyPairGenerator("ECDSA");
			eCKeyPairGenerator.Init(new KeyGenerationParameters(new SecureRandom(), 384));
			SessionKeys = eCKeyPairGenerator.GenerateKeyPair();
			GameCore.Console.AddLog("Session keys generated (ECDSA)!", Color.gray, nospace: true);
			if (ServerStatic.IsDedicated || StartupArgs.Args.Any((string arg) => string.Equals(arg, "-noauth", StringComparison.OrdinalIgnoreCase)))
			{
				Platform = DistributionPlatform.Dedicated;
				GameCore.Console.AddLog("Running as dedicated server. Skipping distribution platform detection.", Color.green, nospace: true);
				return;
			}
			if (StartupArgs.Args.Any((string arg) => string.Equals(arg, "-steam", StringComparison.OrdinalIgnoreCase)) && StartupArgs.Args.All((string arg) => !string.Equals(arg, "-fdiscord", StringComparison.OrdinalIgnoreCase)))
			{
				Platform = DistributionPlatform.Steam;
				GameCore.Console.AddLog("Detected distribution platform: Steam", Color.green, nospace: true);
				SteamManager.StartClient();
				Authenticate();
				return;
			}
			if (!StartupArgs.Args.Any((string arg) => string.Equals(arg, "-discord", StringComparison.OrdinalIgnoreCase) || string.Equals(arg, "-fdiscord", StringComparison.OrdinalIgnoreCase)))
			{
				Platform = DistributionPlatform.Steam;
				GameCore.Console.AddLog("Cannot detect distribution platform. Using default platform: Steam", Color.green, nospace: true);
				SteamManager.StartClient();
				Authenticate();
				return;
			}
			Platform = DistributionPlatform.Discord;
			GameCore.Console.AddLog("Detected distribution platform: Discord", Color.green, nospace: true);
			try
			{
				Discord = new global::Discord.Discord(420676877766623232L, 1uL);
				DiscordState = "Loaded!";
				Discord.SetLogHook(global::Discord.LogLevel.Debug, delegate(global::Discord.LogLevel level, string message)
				{
					switch (level)
					{
					case global::Discord.LogLevel.Error:
						UnityEngine.Debug.LogError(message);
						break;
					case global::Discord.LogLevel.Warn:
						UnityEngine.Debug.LogWarning(message);
						break;
					default:
						UnityEngine.Debug.Log(message);
						break;
					}
				});
				Discord.GetApplicationManager().GetOAuth2Token(delegate(global::Discord.Result result, ref global::Discord.OAuth2Token token)
				{
					GameCore.Console.AddLog(string.Format("Obtained auth token from Discord with status \"{0}\".", result), Color.gray, nospace: true);
					if (result == global::Discord.Result.Ok)
					{
						UnityEngine.Debug.Log("Discord OAuth2 token obtained.");
						DiscordOAuth2Token = token.AccessToken;
						Authenticate();
						DiscordState = "Authenticated!";
					}
					else
					{
						DiscordState = string.Format("Failed {0}", result);
					}
				});
			}
			catch (Exception ex)
			{
				DiscordState = "Failed " + ex.Message;
				UnityEngine.Debug.LogException(ex);
			}
		}

		private static void FinalizeServerAuthentication(AuthenticationResponse msg)
		{
			NetworkClient.Send(msg);
		}
	}
}
