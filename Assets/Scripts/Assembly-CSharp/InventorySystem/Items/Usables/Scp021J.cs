using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items.MarshmallowMan;
using MapGeneration.Holidays;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables
{
	public class Scp021J : Consumable, IHolidayItem
	{
		public const float MaxEvilAHP = 450f;

		public HolidayType[] TargetHolidays => new HolidayType[1] { HolidayType.Christmas };

		protected override void OnEffectsActivated()
		{
			base.Owner.playerEffectsController.AllEffects.ForEach(DisableEffectConditionally);
			AhpStat module = base.Owner.playerStats.GetModule<AhpStat>();
			module.ServerKillAllProcesses();
			AhpProcess evilProcess = module.ServerAddProcess(450f, 450f, 0f, 1f, 0f, persistant: true);
			foreach (KeyValuePair<ushort, ItemBase> item in base.Owner.inventory.UserInventory.Items)
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
