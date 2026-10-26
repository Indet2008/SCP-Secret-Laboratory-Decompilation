using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items.MarshmallowMan;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyEvil : ICandy
	{
		public const float MaxEvilAHP = 450f;

		public CandyKindID Kind => CandyKindID.Evil;

		public float SpawnChanceWeight { get; private set; } = 0.5f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.AllEffects.ForEach(DisableEffectConditionally);
			AhpStat module = hub.playerStats.GetModule<AhpStat>();
			module.ServerKillAllProcesses();
			AhpProcess evilProcess = module.ServerAddProcess(450f, 450f, 0f, 1f, 0f, persistant: true);
			foreach (KeyValuePair<ushort, ItemBase> item in hub.inventory.UserInventory.Items)
			{
				if (item.Value is MarshmallowItem marshmallowItem)
				{
					marshmallowItem.ReleaseEvil(evilProcess);
				}
			}
		}

		private static void DisableEffectConditionally(StatusEffectBase fx)
		{
			if (!(fx is BodyshotReduction) && !(fx is Invigorated) && !(fx is MovementBoost) && !(fx is RainbowTaste) && !(fx is Vitality) && !(fx is Blurred) && !(fx is Burned) && !(fx is Concussed) && !(fx is Deafened) && !(fx is CardiacArrest) && !(fx is CustomPlayerEffects.Scp207) && !(fx is CustomPlayerEffects.AntiScp207))
			{
				if (fx is MarshmallowEffect)
				{
					fx.ServerSetState(1);
				}
			}
			else
			{
				fx.ServerDisable();
			}
		}
	}
}
