using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HumeShield
{
	public interface IHumeShieldProvider
	{
		bool ForceBarVisible { get; }

		float HsMax { get; }

		float HsRegeneration { get; }

		Color? HsWarningColor { get; }

		static void GetForHub(ReferenceHub hub, out bool isBarVisible, out float hsMax, out float hsRegen, out Color? warningColor)
		{
			if (hub.roleManager.CurrentRole is IHumeShieldedRole { HumeShieldModule: var humeShieldModule })
			{
				isBarVisible = humeShieldModule.ForceBarVisible;
				hsMax = humeShieldModule.HsMax;
				hsRegen = humeShieldModule.HsRegeneration;
				warningColor = humeShieldModule.HsWarningColor;
			}
			else
			{
				isBarVisible = false;
				hsMax = 0f;
				hsRegen = 0f;
				warningColor = null;
			}
			foreach (KeyValuePair<ushort, ItemBase> item in hub.inventory.UserInventory.Items)
			{
				if (item.Value is IHumeShieldProvider humeShieldProvider)
				{
					isBarVisible |= humeShieldProvider.ForceBarVisible;
					hsMax += humeShieldProvider.HsMax;
					hsRegen += humeShieldProvider.HsRegeneration;
					Color? color = warningColor;
					if (!color.HasValue)
					{
						warningColor = humeShieldProvider.HsWarningColor;
					}
				}
			}
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			for (int i = 0; i < allEffects.Length; i++)
			{
				if (allEffects[i] is IHumeShieldProvider humeShieldProvider2)
				{
					isBarVisible |= humeShieldProvider2.ForceBarVisible;
					hsMax += humeShieldProvider2.HsMax;
					hsRegen += humeShieldProvider2.HsRegeneration;
					Color? color = warningColor;
					if (!color.HasValue)
					{
						warningColor = humeShieldProvider2.HsWarningColor;
					}
				}
			}
		}

		static void GetForHub(ReferenceHub hub, out HumeShieldStat stat, out bool isBarVisible, out float hsMax, out float hsRegen, out Color? warningColor)
		{
			stat = hub.playerStats.GetModule<HumeShieldStat>();
			GetForHub(hub, out isBarVisible, out hsMax, out hsRegen, out warningColor);
		}
	}
}
