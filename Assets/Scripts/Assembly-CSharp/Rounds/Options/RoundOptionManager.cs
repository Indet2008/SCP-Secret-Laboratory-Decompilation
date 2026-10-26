using System.Collections.Generic;
using UnityEngine;

namespace Rounds.Options
{
	public static class RoundOptionManager
	{
		public static readonly List<IRoundOption> LobbyActions = new List<IRoundOption>();

		public static readonly List<IRoundOption> RoundStartActions = new List<IRoundOption>();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CharacterClassManager.ServerOnRoundStartTriggered += OnRoundStarted;
			CharacterClassManager.ServerWaitingForPlayers += OnWaitingForPlayers;
		}

		private static void OnWaitingForPlayers()
		{
			foreach (IRoundOption lobbyAction in LobbyActions)
			{
				lobbyAction.Invoke();
			}
		}

		private static void OnRoundStarted()
		{
			foreach (IRoundOption roundStartAction in RoundStartActions)
			{
				roundStartAction.Invoke();
			}
		}
	}
}
