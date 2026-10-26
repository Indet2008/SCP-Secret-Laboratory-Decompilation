using GameCore;

namespace MapGeneration.Holidays
{
	public static class HolidayUtils
	{
		public static HolidayType GetActiveHoliday(bool mustBeForced = false)
		{
			if (mustBeForced || Version.ActiveHoliday != HolidayType.None)
			{
				return Version.ActiveHoliday;
			}
			return HolidayType.None;
		}

		public static bool IsHolidayActive(HolidayType holiday, bool mustBeForced = false)
		{
			return GetActiveHoliday(mustBeForced) == holiday;
		}

		public static bool IsAnyHolidayActive(this HolidayType[] holidays, bool mustBeForced = false)
		{
			if (holidays == null || holidays.Length == 0)
			{
				return true;
			}
			for (int i = 0; i < holidays.Length; i++)
			{
				if (IsHolidayActive(holidays[i], mustBeForced))
				{
					return true;
				}
			}
			return false;
		}

		public static bool IsAnyHolidayActive(bool mustBeForced = false)
		{
			return GetActiveHoliday(mustBeForced) != HolidayType.None;
		}

		public static bool TryGetResult<TArray, TValue>(this TArray[] holidayData, out TValue result) where TArray : IHolidayFetchableData<TValue>
		{
			if (holidayData == null)
			{
				result = default;
				return false;
			}
			foreach (IHolidayFetchableData<TValue> holidayFetchableData in holidayData)
			{
				if (IsHolidayActive(holidayFetchableData.Holiday))
				{
					result = holidayFetchableData.Result;
					return true;
				}
			}
			result = default;
			return false;
		}
	}
}
