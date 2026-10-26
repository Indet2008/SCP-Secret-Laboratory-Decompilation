using MapGeneration.Holidays;

namespace InventorySystem.Items.Usables.Scp330
{
	public class RandomHauntedEffectsOutcome : RandomCandyEffectsOutcome
	{
		public override bool IsAvailable => HolidayUtils.IsHolidayActive(HolidayType.Halloween);

		protected override ICandy[] CandyPool => Scp330Candies.HauntedCandies;

		protected override int MinGrantedEffects => 1;

		protected override int MaxGrantedEffects => 1;
	}
}
