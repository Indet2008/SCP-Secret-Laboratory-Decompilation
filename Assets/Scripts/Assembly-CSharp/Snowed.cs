using CustomPlayerEffects;
using MapGeneration.Holidays;

public class Snowed : StatusEffectBase, IHolidayEffect
{
	public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
	{
		HolidayType.Christmas,
		HolidayType.AprilFools
	};
}
