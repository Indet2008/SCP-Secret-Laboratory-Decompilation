using System;
using MapGeneration.Holidays;

[Serializable]
public struct ClutterStruct
{
	public string descriptor;

	public Clutter clutterComponent;

	public float chanceToSpawn;

	public bool invertTimespan;

	public HolidayType[] targetHolidays;
}
