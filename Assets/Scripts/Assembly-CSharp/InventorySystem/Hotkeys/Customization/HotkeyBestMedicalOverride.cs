using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items;
using PlayerStatsSystem;
using Utils.NonAllocLINQ;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyBestMedicalOverride : HotkeyOverrideBase
	{
		private static readonly List<ItemType> BestToWorst = new List<ItemType>();

		private static readonly ItemType[] HandledItems = new ItemType[4]
		{
			ItemType.SCP500,
			ItemType.Adrenaline,
			ItemType.Medkit,
			ItemType.Painkillers
		};

		public override HotkeyOverrideOption OptionType => HotkeyOverrideOption.BestMedical;

		public override HotkeysTranslation OptionName => HotkeysTranslation.OverrideBestMedical;

		public override HotkeysTranslation? Description => HotkeysTranslation.OverrideBestMedicalHint;

		private void UpdateConditions(PlayerStats stats, PlayerEffectsController effectsController)
		{
			BestToWorst.Clear();
			float curValue = stats.GetModule<HealthStat>().CurValue;
			float normalizedValue = stats.GetModule<StaminaStat>().NormalizedValue;
			if (effectsController.TryGetEffect<CardiacArrest>(out var playerEffect) && playerEffect.Intensity > 0)
			{
				if (curValue < 50f)
				{
					BestToWorst.AddIfNotContains(ItemType.SCP500);
				}
				BestToWorst.AddIfNotContains(ItemType.Adrenaline);
				BestToWorst.AddIfNotContains(ItemType.SCP500);
			}
			if (curValue < 35f)
			{
				BestToWorst.Add(ItemType.SCP500);
				BestToWorst.Add(ItemType.Medkit);
				BestToWorst.Add(ItemType.Painkillers);
			}
			else if (curValue < 60f)
			{
				BestToWorst.AddIfNotContains(ItemType.Medkit);
				BestToWorst.AddIfNotContains(ItemType.Painkillers);
				BestToWorst.AddIfNotContains(ItemType.SCP500);
			}
			else if (curValue < 80f)
			{
				BestToWorst.AddIfNotContains(ItemType.Painkillers);
				BestToWorst.AddIfNotContains(ItemType.Medkit);
				BestToWorst.AddIfNotContains(ItemType.SCP500);
			}
			if (normalizedValue < 0.15f)
			{
				BestToWorst.AddIfNotContains(ItemType.Adrenaline);
			}
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result)
		{
			UpdateConditions(player.playerStats, player.playerEffectsController);
			ItemType[] itemsByQueue = HotkeyUtils.GetItemsByQueue(hotkeyId);
			foreach (ItemType item in BestToWorst)
			{
				if (System.Array.IndexOf(itemsByQueue, item) >= 0 && player.inventory.TryGetInventoryItem(item, out result))
				{
					return true;
				}
			}
			result = null;
			return false;
		}

		public override bool CheckAvailability(List<PoolElementData> elements)
		{
			return elements.CountMatches(HandledItems) > 1;
		}
	}
}
