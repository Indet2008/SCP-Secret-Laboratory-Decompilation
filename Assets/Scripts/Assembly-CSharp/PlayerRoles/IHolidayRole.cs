using GameCore;
using MapGeneration.Holidays;

namespace PlayerRoles
{
	public interface IHolidayRole
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
