using System.Collections.Generic;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class ArmyOfOneHandler : AchievementHandlerBase
	{
		private const int KillsNeeded = 4;

		private static readonly Dictionary<ReferenceHub, List<ItemType>> Kills = new Dictionary<ReferenceHub, List<ItemType>>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		internal override void OnRoundStarted()
		{
			Kills.Clear();
		}

		private static void OnServerRoleSet(ReferenceHub hub, RoleTypeId roleTypeId, RoleChangeReason changeReason)
		{
			if (changeReason != RoleChangeReason.Escaped)
			{
				Kills.Remove(hub);
			}
		}

		private static void OnAnyPlayerDied(ReferenceHub victim, DamageHandlerBase handler)
		{
			if (!NetworkServer.active || !(handler is AttackerDamageHandler attackerDamageHandler))
			{
				return;
			}
			ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
			if (hub == null || !hub.IsHuman() || !HitboxIdentity.IsEnemy(attackerDamageHandler.Attacker.Role, victim.GetRoleId()))
			{
				return;
			}
			ItemType itemType = GetItemType(handler);
			if (itemType == ItemType.None)
			{
				return;
			}
			if (!Kills.TryGetValue(hub, out var value))
			{
				Kills[hub] = new List<ItemType> { itemType };
			}
			else if (!value.Contains(itemType))
			{
				value.Add(itemType);
				Kills[hub] = value;
				if (value.Count >= 4)
				{
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.ArmyOfOne);
				}
			}
		}

		private static ItemType GetItemType(DamageHandlerBase handler)
		{
			if (!(handler is FirearmDamageHandler firearmDamageHandler))
			{
				if (!(handler is DisruptorDamageHandler))
				{
					if (!(handler is JailbirdDamageHandler))
					{
						if (!(handler is MicroHidDamageHandler))
						{
							if (handler is ExplosionDamageHandler explosionDamageHandler)
							{
								return ExplosionToItemType(explosionDamageHandler.ExplosionType);
							}
							return ItemType.None;
						}
						return ItemType.MicroHID;
					}
					return ItemType.Jailbird;
				}
				return ItemType.ParticleDisruptor;
			}
			return firearmDamageHandler.WeaponType;
		}

		private static ItemType ExplosionToItemType(ExplosionType explosionType)
		{
			return explosionType switch
			{
				ExplosionType.Grenade => ItemType.GrenadeHE, 
				ExplosionType.Disruptor => ItemType.ParticleDisruptor, 
				ExplosionType.Jailbird => ItemType.Jailbird, 
				_ => ItemType.None, 
			};
		}
	}
}
