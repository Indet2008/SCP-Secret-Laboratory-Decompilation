using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;

namespace MapGeneration.Decoration
{
	public class DeathAlarmTrigger : AlarmTriggerBase
	{
		private static readonly Team[] IgnoredTeams = new Team[2]
		{
			Team.FoundationForces,
			Team.Scientists
		};

		protected override float Duration => 20f;

		protected override void Start()
		{
			base.Start();
			if (NetworkServer.active)
			{
				PlayerStats.OnAnyPlayerDied += HandlePlayerDied;
			}
		}

		private void HandlePlayerDied(ReferenceHub player, DamageHandlerBase damageHandler)
		{
			if (this == null)
			{
				PlayerStats.OnAnyPlayerDied -= HandlePlayerDied;
				return;
			}
			if (player.roleManager.CurrentRole is IFpcRole fpcRole && IsInRange(fpcRole.FpcModule.Position) && damageHandler is AttackerDamageHandler attackerDamageHandler && !IgnoredTeams.Contains(attackerDamageHandler.Attacker.Hub.GetTeam()))
			{
				ServerTriggerAlarm();
			}
		}

		// Unsubscribe unconditionally: the server may already be stopped when the room is destroyed,
		// which left a handler on the static event pointing at a destroyed room.
		private void OnDestroy()
		{
			PlayerStats.OnAnyPlayerDied -= HandlePlayerDied;
		}
	}
}
