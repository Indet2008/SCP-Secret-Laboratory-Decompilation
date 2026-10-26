using MapGeneration.Holidays;

namespace CustomPlayerEffects
{
	public class OrangeWitness : StatusEffectBase, IHolidayEffect
	{
		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };
	}
}
