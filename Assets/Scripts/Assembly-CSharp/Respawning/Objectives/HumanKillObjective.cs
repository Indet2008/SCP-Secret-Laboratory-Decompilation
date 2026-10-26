using Footprinting;
using InventorySystem.Items;
using LabApi.Events.Arguments.ObjectiveEvents;
using LabApi.Events.Handlers;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp049;
using PlayerStatsSystem;

namespace Respawning.Objectives
{
	public class HumanKillObjective : HumanObjectiveBase<KillObjectiveFootprint>
	{
		private const float MilitantKillInfluence = 1f;

		private const float MilitantKillTimer = -4f;

		private const float ScpKillInfluence = 15f;

		private const float ScpKillTimer = -10f;

		private const float ZombieKillInfluence = 0f;

		private const float ZombieKillTime = -5f;

		protected override KillObjectiveFootprint ClientCreateFootprint()
		{
			return new KillObjectiveFootprint();
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			PlayerStats.OnAnyPlayerDied += OnKill;
		}

		private void OnKill(ReferenceHub victim, DamageHandlerBase dhb)
		{
			if (!(dhb is AttackerDamageHandler { Attacker: var footprint }) || footprint.Hub == null)
			{
				return;
			}
			RoleTypeId role = footprint.Role;
			Faction faction = role.GetFaction();
			if (!IsValidFaction(faction) || !IsValidEnemy(role, victim))
			{
				return;
			}
			bool num = victim.IsSCP(includeZombies: false);
			bool flag = victim.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Scp0492;
			float timeToGrant;
			float influenceToGrant;
			if (num)
			{
				timeToGrant = -10f;
				influenceToGrant = 15f;
			}
			else if (flag)
			{
				timeToGrant = -5f;
				influenceToGrant = 0f;
			}
			else
			{
				timeToGrant = -4f;
				influenceToGrant = 1f;
			}
			bool sendToPlayers = true;
			EnemyKillingObjectiveEventArgs e = new EnemyKillingObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, victim, sendToPlayers);
			ObjectiveEvents.OnKillingEnemyCompleting(e);
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
				GrantInfluence(faction, influenceToGrant);
				ReduceTimer(faction, timeToGrant);
				if (sendToPlayers)
				{
					base.ObjectiveFootprint = new KillObjectiveFootprint
					{
						AchievingPlayer = new ObjectiveHubFootprint(footprint),
						VictimFootprint = new ObjectiveHubFootprint(victim),
						InfluenceReward = influenceToGrant,
						TimeReward = timeToGrant
					};
					ServerSendUpdate();
				}
				EnemyKilledObjectiveEventArgs ev = new EnemyKilledObjectiveEventArgs(footprint.Hub, faction, influenceToGrant, timeToGrant, sendToPlayers, victim);
				ObjectiveEvents.OnKilledEnemyCompleted(ev);
				ObjectiveEvents.OnCompleted(ev);
			}
		}

		private bool IsValidEnemy(RoleTypeId attacker, ReferenceHub victim)
		{
			PlayerRoleBase currentRole = victim.roleManager.CurrentRole;
			switch (currentRole.Team)
			{
			case Team.Scientists:
			case Team.ClassD:
			{
				ItemBase curInstance = victim.inventory.CurInstance;
				if (!(curInstance == null))
				{
					ItemCategory category = curInstance.Category;
					if (category == ItemCategory.Firearm || category == ItemCategory.SpecialWeapon || category == ItemCategory.Grenade)
					{
						break;
					}
				}
				return false;
			}
			case Team.SCPs:
				if (currentRole.RoleTypeId == RoleTypeId.Scp0492 && Scp049ResurrectAbility.GetResurrectionsNumber(victim) > 1)
				{
					return false;
				}
				break;
			default:
				return false;
			case Team.FoundationForces:
			case Team.ChaosInsurgency:
				break;
			}
			return HitboxIdentity.IsEnemy(attacker, victim.GetRoleId());
		}
	}
}
