using CustomPlayerEffects;
using GameCore;
using InventorySystem.Items.Keycards;
using InventorySystem.Items.MicroHID;
using Mirror;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp096;
using PlayerRoles.PlayableScps.Scp939;
using PlayerStatsSystem;
using UnityEngine;

namespace Achievements.Handlers
{
	public class GeneralKillsHandler : AchievementHandlerBase
	{
		private const int AnomalouslyEfficientTime = 60;

		private const int ArizonaRangerDistance = 25;

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
		}

		private static void HandleDeath(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			if (handler is AttackerDamageHandler attackerDamageHandler && attackerDamageHandler.Attacker.Hub != null)
			{
				HandleAttackerKill(deadPlayer, attackerDamageHandler);
			}
			if (!(handler is ExplosionDamageHandler explosionDamageHandler))
			{
				if (!(handler is Scp939DamageHandler scp939DamageHandler))
				{
					if (!(handler is MicroHidDamageHandler microHidDamageHandler))
					{
						if (handler is UniversalDamageHandler universalDamageHandler && universalDamageHandler.TranslationId == DeathTranslations.Tesla.Id && deadPlayer.inventory.CurInstance is MicroHIDItem)
						{
							Send(deadPlayer, AchievementName.Overcurrent);
						}
					}
					else if (microHidDamageHandler.Attacker.Hub != null && deadPlayer.IsSCP())
					{
						Send(microHidDamageHandler.Attacker.Hub, AchievementName.MicrowaveMeal);
					}
				}
				else if (scp939DamageHandler.Attacker.Hub != null)
				{
					HandleScp939Kill(deadPlayer, scp939DamageHandler);
				}
			}
			else if (explosionDamageHandler.Attacker.Hub != null && explosionDamageHandler.Attacker.Hub != deadPlayer && explosionDamageHandler.ExplosionType == ExplosionType.Grenade)
			{
				Send(explosionDamageHandler.Attacker.Hub, AchievementName.FireInTheHole);
			}
		}

		private static void HandleScp939Kill(ReferenceHub deadPlayer, Scp939DamageHandler scp939DH)
		{
			if (deadPlayer.IsHuman() && scp939DH.Attacker.Role == RoleTypeId.Scp939 && deadPlayer.playerEffectsController.TryGetEffect<AmnesiaVision>(out var playerEffect) && playerEffect.IsEnabled && scp939DH.Scp939DamageType == Scp939DamageType.LungeTarget)
			{
				Send(scp939DH.Attacker.Hub, AchievementName.AmnesticAmbush);
			}
		}

		private static void HandleAttackerKill(ReferenceHub deadPlayer, AttackerDamageHandler aDH)
		{
			ReferenceHub hub = aDH.Attacker.Hub;
			RoleTypeId roleId = deadPlayer.GetRoleId();
			switch (roleId)
			{
			case RoleTypeId.Scp0492:
				if (hub.IsHuman() && aDH is JailbirdDamageHandler)
				{
					Send(hub, AchievementName.UndeadSpaceProgram);
				}
				break;
			case RoleTypeId.Scp096:
				if ((deadPlayer.roleManager.CurrentRole as Scp096Role).IsRageState(Scp096RageState.Distressed))
				{
					Send(hub, AchievementName.Pacified);
				}
				break;
			}
			switch (aDH.Attacker.Role.GetTeam())
			{
			case Team.Scientists:
				if (deadPlayer.IsSCP())
				{
					Send(hub, AchievementName.SomethingDoneRight);
				}
				break;
			case Team.ClassD:
				if (roleId == RoleTypeId.Scientist && deadPlayer.inventory.CurInstance is KeycardItem)
				{
					Send(hub, AchievementName.AccessGranted);
				}
				break;
			case Team.SCPs:
				if (RoundStart.RoundStartTimer.Elapsed.TotalSeconds < 60.0)
				{
					Send(hub, AchievementName.AnomalouslyEfficient);
				}
				break;
			}
			if (aDH is FirearmDamageHandler { WeaponType: ItemType.GunRevolver } firearmDamageHandler && (deadPlayer.IsHuman() || deadPlayer.GetRoleId() == RoleTypeId.Scp0492) && firearmDamageHandler.Hitbox == HitboxType.Headshot && !(Vector3.Distance(deadPlayer.transform.position, hub.transform.position) < 25f))
			{
				Send(hub, AchievementName.ArizonaRanger);
			}
		}

		private static void Send(ReferenceHub hub, AchievementName name)
		{
			if (hub != null)
			{
				AchievementHandlerBase.ServerAchieve(hub.networkIdentity.connectionToClient, name);
			}
		}
	}
}
