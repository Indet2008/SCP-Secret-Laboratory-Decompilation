using MapGeneration;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using PlayerStatsSystem;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Rewards
{
	public static class TerminationRewards
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerStats.OnAnyPlayerDied += OnHumanTerminated;
			Scp106Attack.OnPlayerTeleported += OnPlayerTeleported;
		}

		private static void OnPlayerTeleported(ReferenceHub scp106, ReferenceHub hub)
		{
			OnHumanTerminated(hub, new ScpDamageHandler(scp106, DeathTranslations.PocketDecay));
		}

		private static void OnHumanTerminated(ReferenceHub ply, DamageHandlerBase damageHandler)
		{
			if (NetworkServer.active)
			{
				Scp079Role.ActiveInstances.ForEach((Scp079Role x) =>
				{
					GainReward(x, ply, damageHandler);
				});
			}
		}

		private static void GainReward(Scp079Role scp079, ReferenceHub deadPly, DamageHandlerBase damageHandler)
		{
			PlayerRoleBase currentRole = deadPly.roleManager.CurrentRole;
			if (!(currentRole is IFpcRole) || !TryGetBaseReward(currentRole.RoleTypeId, out var amount))
			{
				return;
			}
			Scp079HudTranslation scp079HudTranslation = EvaluateGainReason(deadPly, damageHandler);
			bool num = deadPly.TryGetCurrentRoom(out var room);
			bool flag = num && Scp079RewardManager.CheckForRoomInteractions(scp079, room);
			bool flag2 = num && scp079.CurrentCamera.Room == room;
			int reward;
			switch (scp079HudTranslation)
			{
			default:
				return;
			case Scp079HudTranslation.ExpGainTerminationDirect:
				if (!flag)
				{
					return;
				}
				reward = amount * 2;
				break;
			case Scp079HudTranslation.ExpGainTerminationAssist:
				if (!flag)
				{
					scp079HudTranslation = Scp079HudTranslation.ExpGainTerminationWitness;
					goto case Scp079HudTranslation.ExpGainTerminationWitness;
				}
				reward = amount;
				break;
			case Scp079HudTranslation.ExpGainTerminationWitness:
				if (!flag2)
				{
					return;
				}
				reward = amount / 2;
				break;
			}
			Scp079RewardManager.GrantExp(scp079, reward, scp079HudTranslation, currentRole.RoleTypeId);
		}

		private static Scp079HudTranslation EvaluateGainReason(ReferenceHub deadPlayer, DamageHandlerBase damageHandler)
		{
			if (CheckDirectTermination(damageHandler))
			{
				return Scp079HudTranslation.ExpGainTerminationDirect;
			}
			if (damageHandler is AttackerDamageHandler attackerDamageHandler)
			{
				if (attackerDamageHandler.Attacker.Role.GetTeam() == Team.SCPs)
				{
					return Scp079HudTranslation.ExpGainTerminationAssist;
				}
				if (attackerDamageHandler.Attacker.Hub == deadPlayer)
				{
					return Scp079HudTranslation.ExpGainTerminationAssist;
				}
				return Scp079HudTranslation.Zoom;
			}
			return Scp079HudTranslation.ExpGainTerminationAssist;
		}

		private static bool CheckDirectTermination(DamageHandlerBase damageHandler)
		{
			if (damageHandler is UniversalDamageHandler universalDamageHandler)
			{
				return universalDamageHandler.TranslationId == DeathTranslations.Tesla.Id;
			}
			return false;
		}

		public static bool TryGetBaseReward(RoleTypeId rt, out int amount)
		{
			switch (rt.GetTeam())
			{
			case Team.ChaosInsurgency:
				amount = 50;
				return true;
			case Team.ClassD:
				amount = 30;
				return true;
			case Team.Scientists:
				amount = 40;
				return true;
			case Team.OtherAlive:
				amount = 50;
				return true;
			case Team.FoundationForces:
			{
				bool flag = rt == RoleTypeId.FacilityGuard;
				amount = (flag ? 30 : 50);
				return true;
			}
			case Team.Flamingos:
				amount = 15;
				return true;
			default:
				amount = 0;
				return false;
			}
		}
	}
}
