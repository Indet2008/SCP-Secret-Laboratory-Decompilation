using MapGeneration.Holidays;

namespace CustomPlayerEffects
{
	public class TraumatizedByEvil : StatusEffectBase, IHealableEffect, IHolidayEffect
	{
		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		public bool IsHealable(ItemType item)
		{
			return item == ItemType.SCP500;
		}
	}
}
