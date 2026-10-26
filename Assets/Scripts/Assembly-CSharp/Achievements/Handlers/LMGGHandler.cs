using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class LMGGHandler : AchievementHandlerBase
	{
		private const int KillsNeeded = 3;

		private static readonly Dictionary<ReferenceHub, double> LastHeldTime = new Dictionary<ReferenceHub, double>();

		private static readonly Dictionary<ReferenceHub, int> KillsSinceHeld = new Dictionary<ReferenceHub, int>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
		}

		internal override void OnRoundStarted()
		{
			LastHeldTime.Clear();
			KillsSinceHeld.Clear();
		}

		private void OnAnyPlayerDied(ReferenceHub victim, DamageHandlerBase handler)
		{
			if (!NetworkServer.active || !(handler is FirearmDamageHandler { WeaponType: var weaponType } firearmDamageHandler) || (weaponType != ItemType.GunFRMG0 && weaponType != ItemType.GunLogicer))
			{
				return;
			}
			ReferenceHub hub = firearmDamageHandler.Attacker.Hub;
			if (!hub.IsHuman() || !HitboxIdentity.IsEnemy(firearmDamageHandler.Attacker.Role, victim.GetRoleId()))
			{
				return;
			}
			SimpleTriggerModule.ReceivedData data = SimpleTriggerModule.GetData(firearmDamageHandler.Firearm.ItemSerial);
			if (!LastHeldTime.TryGetValue(hub, out var value))
			{
				value = data.PressTime;
				LastHeldTime[hub] = value;
			}
			if (Math.Abs(data.PressTime - value) > 1E-09)
			{
				LastHeldTime[hub] = data.PressTime;
				KillsSinceHeld[hub] = 1;
				return;
			}
			if (!KillsSinceHeld.TryGetValue(hub, out var value2))
			{
				value2 = 0;
			}
			value2 = (KillsSinceHeld[hub] = value2 + 1);
			if (value2 >= 3)
			{
				AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.LMGG);
			}
		}
	}
}
