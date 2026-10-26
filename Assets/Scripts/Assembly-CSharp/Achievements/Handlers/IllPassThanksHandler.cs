using InventorySystem.Items.MicroHID;
using InventorySystem.Items.MicroHID.Modules;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp106;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class IllPassThanksHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
			Scp106Attack.OnPlayerTeleported += PlayerTeleported;
		}

		private void PlayerTeleported(ReferenceHub scp106, ReferenceHub hub)
		{
			if (CheckConditionsForVictim(hub))
			{
				AchievementHandlerBase.ServerAchieve(scp106.connectionToClient, AchievementName.IllPassThanks);
			}
		}

		private void HandleDeath(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (handler is AttackerDamageHandler attackerDamageHandler)
			{
				ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
				if (!(hub == null) && hub.IsSCP() && CheckConditionsForVictim(deadPlayer))
				{
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.IllPassThanks);
				}
			}
		}

		private bool CheckConditionsForVictim(ReferenceHub hub)
		{
			if (hub.inventory.CurInstance is MicroHIDItem microHIDItem && microHIDItem != null)
			{
				MicroHidPhase phase = microHIDItem.CycleController.Phase;
				return phase == MicroHidPhase.WindingUp || phase == MicroHidPhase.Firing;
			}
			return false;
		}
	}
}
