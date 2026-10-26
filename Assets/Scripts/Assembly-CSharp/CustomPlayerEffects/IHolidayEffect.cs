using GameCore;
using MapGeneration.Holidays;

namespace CustomPlayerEffects
{
	public interface IHolidayEffect
	{
		bool IsAvailable
		{
			get
			{
				if (TargetHolidays.IsAnyHolidayActive(mustBeForced: true))
				{
					return true;
				}
				Version.VersionType buildType = Version.BuildType;
				return buildType == Version.VersionType.Development || buildType == Version.VersionType.Nightly;
			}
		}

		HolidayType[] TargetHolidays { get; }
	}
}
