using Interactables.Interobjects.DoorUtils;
using MapGeneration.Holidays;

namespace CustomPlayerEffects
{
	public class TemporaryBypass : StatusEffectBase, IHolidayEffect, IDoorPermissionProvider
	{
		public const byte ScpBypass = 1;

		public const byte FullBypass = 2;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		public bool IsFullBypass => base.Intensity > 1;

		public bool IsScpBypass => base.Intensity == 1;

		public PermissionUsed PermissionsUsedCallback => null;

		public DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			if (IsFullBypass)
			{
				return DoorPermissionFlags.All;
			}
			if (IsScpBypass)
			{
				return DoorPermissionFlags.ScpOverride;
			}
			return DoorPermissionFlags.None;
		}
	}
}
