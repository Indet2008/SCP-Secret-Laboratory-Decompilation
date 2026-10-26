using GameCore;
using MapGeneration.Holidays;

namespace InventorySystem.Items
{
	public interface IHolidayItem
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
