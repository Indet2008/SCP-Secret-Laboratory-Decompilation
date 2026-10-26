using System;
using System.Collections.Generic;
using GameCore;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SpawnProtected : StatusEffectBase, ISpectatorDataPlayerEffect, ICustomDisplayName, IDamageModifierEffect, IPulseEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::CustomPlayerEffects.PostProcessEffectPulse _pulseEffect;


		public static bool IsProtectionEnabled;

		public static bool CanShoot;

		public static bool PreventAllDamage;

		public static float SpawnDuration;

		public static readonly List<Team> ProtectedTeams = new List<Team>();

		private static bool _eventAssigned = false;

		public string DisplayName => "Spawn Protection";

		public bool CanBeDisplayed => true;

		public bool DamageModifierActive => base.IsEnabled;

		public override EffectClassification Classification => EffectClassification.Positive;

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			if (!TryGiveProtection(base.Hub))
			{
				base.OnRoleChanged(previousRole, newRole);
			}
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			if (!IsProtectionEnabled)
			{
				return 1f;
			}
			if (!(handler is AttackerDamageHandler attackerDamageHandler))
			{
				if (!PreventAllDamage)
				{
					return 1f;
				}
				return CancelDamage();
			}
			if (!(attackerDamageHandler.Attacker.Hub == base.Hub))
			{
				return CancelDamage();
			}
			return 1f;
		}

		public bool GetSpectatorText(out string display)
		{
			display = "Spawn protected";
			return base.IsEnabled;
		}

		public void ExecutePulse()
		{
		}

		private float CancelDamage()
		{
			base.Hub.playerEffectsController.ServerSendPulse<SpawnProtected>();
			return 0f;
		}

		public static bool CheckPlayer(ReferenceHub hub)
		{
			if (NetworkServer.active && !IsProtectionEnabled)
			{
				return false;
			}
			return hub.playerEffectsController.GetEffect<SpawnProtected>().IsEnabled;
		}

		public static bool TryGiveProtection(ReferenceHub hub)
		{
			if (!NetworkServer.active || !IsProtectionEnabled)
			{
				return false;
			}
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!(currentRole is IHealthbarRole))
			{
				return false;
			}
			if (!ProtectedTeams.Contains(currentRole.Team))
			{
				return false;
			}
			hub.playerEffectsController.EnableEffect<SpawnProtected>(SpawnDuration);
			return true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			if (!_eventAssigned)
			{
				ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(RefreshConfigs));
				ServerConfigSynchronizer.OnRefreshed = (Action)Delegate.Combine(ServerConfigSynchronizer.OnRefreshed, new Action(RefreshConfigs));
				_eventAssigned = true;
			}
			RefreshConfigs();
		}

		private static void RefreshConfigs()
		{
			ProtectedTeams.Clear();
			IsProtectionEnabled = ConfigFile.ServerConfig.GetBool("spawn_protect_enabled");
			CanShoot = ConfigFile.ServerConfig.GetBool("spawn_protect_can_shoot");
			PreventAllDamage = ConfigFile.ServerConfig.GetBool("spawn_protect_prevent_all");
			SpawnDuration = ConfigFile.ServerConfig.GetFloat("spawn_protect_time", 8f);
			List<int> intList = ConfigFile.ServerConfig.GetIntList("spawn_protect_team");
			if (intList.Count == 0)
			{
				ProtectedTeams.Add(Team.FoundationForces);
				ProtectedTeams.Add(Team.ChaosInsurgency);
			}
			else
			{
				intList.ForEach((int t) =>
				{
					ProtectedTeams.Add((Team)t);
				});
			}
		}
	}
}
