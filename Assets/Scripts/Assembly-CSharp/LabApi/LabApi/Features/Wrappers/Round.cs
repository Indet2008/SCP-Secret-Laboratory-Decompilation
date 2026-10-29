namespace LabApi.Features.Wrappers
{
	public static class Round
	{
		public static bool IsRoundStarted => RoundSummary.RoundInProgress();

		public static bool IsRoundInProgress
		{
			get
			{
				if (IsRoundStarted)
				{
					return !IsRoundEnded;
				}
				return false;
			}
		}

		public static bool IsRoundEnded => RoundSummary.singleton.IsRoundEnded;

		public static bool CanRoundEnd
		{
			get
			{
				if (IsLocked || (KeepRoundOnOne && global::Utils.NonAllocLINQ.HashsetExtensions.Count(ReferenceHub.AllHubs, (ReferenceHub x) => x.authManager.InstanceMode != global::CentralAuth.ClientInstanceMode.DedicatedServer) < 2) || !IsRoundStarted)
				{
					return false;
				}
				if (IsRoundStarted)
				{
					return !IsLocked;
				}
				return false;
			}
		}

		public static bool KeepRoundOnOne
		{
			get
			{
				return RoundSummary.singleton.KeepRoundOnOne;
			}
			set
			{
				RoundSummary.singleton.KeepRoundOnOne = value;
			}
		}

		public static bool IsLocked
		{
			get
			{
				return RoundSummary.RoundLock;
			}
			set
			{
				RoundSummary.RoundLock = value;
			}
		}

		public static bool IsLobbyLocked
		{
			get
			{
				return global::GameCore.RoundStart.LobbyLock;
			}
			set
			{
				global::GameCore.RoundStart.LobbyLock = value;
			}
		}

		public static int ExtraTargets
		{
			get
			{
				return RoundSummary.singleton.Network_extraTargets;
			}
			set
			{
				RoundSummary.singleton.Network_extraTargets = value;
			}
		}

		public static int ScpTargetsAmount => global::Utils.NonAllocLINQ.HashsetExtensions.Count(ReferenceHub.AllHubs, (ReferenceHub hub) =>
		{
			global::PlayerRoles.Faction faction = global::PlayerRoles.PlayerRolesUtils.GetFaction(hub);
			return faction - 1 <= global::PlayerRoles.Faction.FoundationStaff;
		}) + ExtraTargets;

		public static int TotalDeaths => RoundSummary.Kills;

		public static int KilledBySCPs => RoundSummary.KilledBySCPs;

		public static int EscapedClassD => RoundSummary.EscapedClassD;

		public static int EscapedScientists => RoundSummary.EscapedScientists;

		public static int SurvivingSCPs => RoundSummary.SurvivingSCPs;

		public static int ChangedIntoZombies => RoundSummary.ChangedIntoZombies;

		public static global::System.TimeSpan Duration => global::GameCore.RoundStart.RoundLength;

		public static void Start()
		{
			CharacterClassManager.ForceRoundStart();
		}

		public static void Restart(bool fastRestart = false, bool overrideRestartAction = false, ServerStatic.NextRoundAction restartAction = ServerStatic.NextRoundAction.DoNothing)
		{
			if (overrideRestartAction)
			{
				ServerStatic.StopNextRound = restartAction;
			}
			bool enableFastRestart = CustomNetworkManager.EnableFastRestart;
			CustomNetworkManager.EnableFastRestart = fastRestart;
			global::RoundRestarting.RoundRestart.InitiateRoundRestart();
			CustomNetworkManager.EnableFastRestart = enableFastRestart;
		}

		public static void RestartSilently()
		{
			Restart(fastRestart: true, overrideRestartAction: true);
		}

		public static bool End(bool force = false)
		{
			if (force)
			{
				RoundSummary.singleton.ForceEnd();
				return true;
			}
			if (!CanRoundEnd)
			{
				return false;
			}
			RoundSummary.singleton.ForceEnd();
			return true;
		}
	}
}
