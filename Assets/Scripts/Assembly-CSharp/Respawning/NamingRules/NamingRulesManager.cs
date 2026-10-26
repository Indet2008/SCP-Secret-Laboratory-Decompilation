using System;
using System.Collections.Generic;
using Mirror;
using PlayerRoles;
using UnityEngine;
using Utils.Networking;

namespace Respawning.NamingRules
{
	public static class NamingRulesManager
	{
		public static Dictionary<Team, List<string>> GeneratedNames = new Dictionary<Team, List<string>>();

		private static readonly Dictionary<Team, UnitNamingRule> AllNamingRules = new Dictionary<Team, UnitNamingRule> { [Team.FoundationForces] = new NineTailedFoxNamingRule() };

		private static readonly Team[] PregeneratedNameTeams = new Team[1] { Team.FoundationForces };

		public static event Action<Team, string, int> OnNameAdded;

		public static bool TryGetNamingRule(Team team, out UnitNamingRule rule)
		{
			return AllNamingRules.TryGetValue(team, out rule);
		}

		public static string ClientFetchReceived(Team teamType, int unitNameId)
		{
			if (!GeneratedNames.TryGetValue(teamType, out var value))
			{
				return string.Empty;
			}
			int count = value.Count;
			if (count != 0 && unitNameId < count)
			{
				return value[unitNameId];
			}
			return string.Empty;
		}

		public static void ServerGenerateName(Team team, UnitNamingRule rule)
		{
			rule.GenerateNew();
			new UnitNameMessage
			{
				Team = team,
				NamingRule = rule
			}.SendToHubsConditionally((ReferenceHub x) => true);
		}

		private static void ProcessMessage(UnitNameMessage msg)
		{
			if (GeneratedNames.TryGetValue(msg.Team, out var value))
			{
				value.Add(msg.UnitName);
			}
			else
			{
				value = new List<string> { msg.UnitName };
				GeneratedNames.Add(msg.Team, value);
			}
			int arg = value.Count - 1;
			OnNameAdded?.Invoke(msg.Team, msg.UnitName, arg);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				UnitNameMessageHandler.ResetHistory();
				GeneratedNames.Clear();
				NetworkClient.ReplaceHandler<UnitNameMessage>(ProcessMessage);
				if (NetworkServer.active)
				{
					Team[] pregeneratedNameTeams = PregeneratedNameTeams;
					foreach (Team team in pregeneratedNameTeams)
					{
						if (TryGetNamingRule(team, out var rule))
						{
							ServerGenerateName(team, rule);
						}
					}
				}
			};
		}
	}
}
