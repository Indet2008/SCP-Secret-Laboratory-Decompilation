using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using Respawning.Objectives;
using UnityEngine;

namespace Respawning
{
	public static class FactionInfluenceManager
	{
		public delegate void OnInfluenceModified(Faction faction, float newValue);

		public const float DefaultInfluence = 0f;

		public static readonly Dictionary<Faction, float> Influence = new Dictionary<Faction, float>();

		public static readonly List<FactionObjectiveBase> Objectives = new List<FactionObjectiveBase>
		{
			new HumanKillObjective(),
			new EscapeObjective(),
			new GeneratorActivatedObjective(),
			new ScpItemPickupObjective(),
			new HumanDamageObjective()
		};

		public static event OnInfluenceModified InfluenceModified;

		public static float Get(Faction faction)
		{
			if (!Influence.TryGetValue(faction, out var value))
			{
				value = 0f;
				Influence[faction] = value;
			}
			return value;
		}

		public static void Set(Faction faction, float influence)
		{
			ModifyingFactionInfluenceEventArgs e = new ModifyingFactionInfluenceEventArgs(faction, influence);
			ServerEvents.OnModifyingFactionInfluence(e);
			if (e.IsAllowed)
			{
				faction = e.Faction;
				influence = e.Influence;
				InfluenceModified?.Invoke(faction, influence);
				Influence[faction] = influence;
				if (NetworkServer.active)
				{
					NetworkServer.SendToReady(new InfluenceUpdateMessage
					{
						Faction = faction,
						Influence = influence
					});
					ServerEvents.OnModifiedFactionInfluence(new ModifiedFactionInfluenceEventArgs(faction, influence));
				}
			}
		}

		public static void Add(Faction faction, float influence)
		{
			Set(faction, Get(faction) + influence);
		}

		public static void Remove(Faction faction, float influence)
		{
			Set(faction, Get(faction) - influence);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<InfluenceUpdateMessage>(ClientMessageReceived);
				if (NetworkServer.active)
				{
					ServerResetInfluence();
				}
			};
		}

		private static void ServerResetInfluence()
		{
			foreach (Faction value in Enum.GetValues(typeof(Faction)))
			{
				Influence[value] = 0f;
			}
		}

		private static void ClientMessageReceived(InfluenceUpdateMessage msg)
		{
			if (!NetworkServer.active)
			{
				Set(msg.Faction, msg.Influence);
			}
		}
	}
}
