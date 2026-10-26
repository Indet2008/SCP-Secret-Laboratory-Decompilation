using System.Collections.Generic;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables
{
	public class PlayerHandler
	{
		public CurrentlyUsedItem CurrentUsable = CurrentlyUsedItem.None;

		public readonly List<RegenerationProcess> ActiveRegenerations = new List<RegenerationProcess>();

		public readonly Dictionary<ItemType, float> PersonalCooldowns = new Dictionary<ItemType, float>();

		public void DoUpdate(ReferenceHub hub)
		{
			HealthStat module = hub.playerStats.GetModule<HealthStat>();
			foreach (RegenerationProcess activeRegeneration in ActiveRegenerations)
			{
				activeRegeneration.GetValue(out var isDone, out var value);
				module.ServerHeal(value);
				if (isDone)
				{
					ActiveRegenerations.Remove(activeRegeneration);
					break;
				}
			}
		}

		public void ResetAll()
		{
			CurrentUsable = CurrentlyUsedItem.None;
			ActiveRegenerations.Clear();
			PersonalCooldowns.Clear();
		}
	}
}
