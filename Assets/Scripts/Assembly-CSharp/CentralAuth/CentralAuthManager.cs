using GameCore;
using UnityEngine;

namespace CentralAuth
{
	public static class CentralAuthManager
	{
		private static bool _initialized;

		private static bool _authDebugEnabled;

		public const int TokenVersion = 2;

		public static DistributionPlatform Platform { get; private set; }

		public static global::Discord.Discord Discord { get; private set; }

		internal static AuthStatusType AuthStatusType;

		internal static bool NoWatermarking;

		internal static string ApiToken;

		internal static string Nonce;

		internal static string TokenChallenge;

		internal static string ServerEcdhPublicKey;

		internal static bool ForceRenew;

		internal static bool RequestAuthToken;

		internal static int CurrentPlayerId { get; set; }

		internal static bool Authenticated { get; private set; }

		internal static CentralAuthPreauthToken PreauthToken { get; private set; }

		internal static void InitAuth()
		{
			if (!_initialized)
			{
				_initialized = true;
				CentralServer.Init();
				if (ServerStatic.IsDedicated)
				{
					Platform = DistributionPlatform.Dedicated;
					Console.AddLog("Running as headless dedicated server. Skipping distribution platform detection.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					return;
				}
				// The server build drops client platform detection; the client runs on Steam when the Steam client is available.
				if (!SteamManager.Running)
				{
					SteamManager.StartClient();
				}
				Platform = SteamManager.Running ? DistributionPlatform.Steam : DistributionPlatform.Dedicated;
				Console.AddLog("Distribution platform: " + Platform + " (Steam: " + SteamManager.GetApiState() + ")", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
			}
		}
	}
}
