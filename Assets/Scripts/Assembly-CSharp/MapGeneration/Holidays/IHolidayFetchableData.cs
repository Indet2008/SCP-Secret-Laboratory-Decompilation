namespace MapGeneration.Holidays
{
	public interface IHolidayFetchableData<T>
	{
		HolidayType Holiday { get; }

		T Result { get; }
	}
}
