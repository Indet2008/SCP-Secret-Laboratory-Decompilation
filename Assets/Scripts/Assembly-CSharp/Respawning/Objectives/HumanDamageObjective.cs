using System.Collections.Generic;
using Footprinting;
using LabApi.Events.Arguments.ObjectiveEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace Respawning.Objectives
{
	public class HumanDamageObjective : HumanObjectiveBase<DamageObjectiveFootprint>
	{
		private const float TimerReward = -2f;

		private const float InfluenceReward = 1f;

		private const float HealthThresholdPercentage = 10f;

		private const float MaxPercentage = 100f;

		public static Dictionary<ReferenceHub, int> HealthTracker = new Dictionary<ReferenceHub, int>();

		private static readonly int MaxThresholdAmount = Mathf.FloorToInt(10f);

		protected override DamageObjectiveFootprint ClientCreateFootprint()
		{
			return new DamageObjectiveFootprint();
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			PlayerStats.OnAnyPlayerDamaged += OnPlayerDamaged;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		protected override void OnInstanceReset()
		{
			base.OnInstanceReset();
			HealthTracker.Clear();
		}

		private void OnPlayerDamaged(ReferenceHub victim, DamageHandlerBase dhb)
		{
			if (!NetworkServer.active || !victim.IsSCP(includeZombies: false) || !(dhb is AttackerDamageHandler attackerDamageHandler))
			{
				return;
			}
			Faction faction = attackerDamageHandler.Attacker.Role.GetFaction();
			if (!IsValidFaction(faction) || !victim.playerStats.TryGetModule<HealthStat>(out var module))
			{
				return;
			}
			if (!HealthTracker.TryGetValue(victim, out var value))
			{
				value = 0;
			}
			int num = Mathf.FloorToInt((1f - module.NormalizedValue) * 100f / 10f);
			if (num >= MaxThresholdAmount || num <= value)
			{
				return;
			}
			HealthTracker[victim] = num;
			int num2 = num - value;
			float timeToGrant = -2f * (float)num2;
			float influenceToGrant = 1f * (float)num2;
			bool sendToPlayers = true;
			Footprint footprint = attackerDamageHandler.Attacker;
			ScpDamagingObjectiveEventArgs e = new ScpDamagingObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, victim, sendToPlayers);
			ObjectiveEvents.OnDamagingScpCompleting(e);
			if (!e.IsAllowed)
			{
				return;
			}
			ObjectiveEvents.OnCompleting(e);
			if (e.IsAllowed)
			{
				if (footprint.Hub != e.Player.ReferenceHub)
				{
					footprint = new Footprint(e.Player?.ReferenceHub);
				}
				victim = e.Target.ReferenceHub;
				faction = e.Faction;
				timeToGrant = e.TimeToGrant;
				influenceToGrant = e.InfluenceToGrant;
				sendToPlayers = e.SendToPlayers;
				ReduceTimer(faction, timeToGrant);
				GrantInfluence(faction, influenceToGrant);
				if (sendToPlayers)
				{
					base.ObjectiveFootprint = new DamageObjectiveFootprint
					{
						AchievingPlayer = new ObjectiveHubFootprint(footprint),
						VictimFootprint = new ObjectiveHubFootprint(victim),
						InfluenceReward = influenceToGrant,
						TimeReward = timeToGrant
					};
					ServerSendUpdate();
				}
				ScpDamagedObjectiveEventArgs ev = new ScpDamagedObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, sendToPlayers, victim);
				ObjectiveEvents.OnDamagedScpCompleted(ev);
				ObjectiveEvents.OnCompleted(ev);
			}
		}

		private void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (NetworkServer.active)
			{
				HealthTracker.Remove(userHub);
			}
		}
	}
}
