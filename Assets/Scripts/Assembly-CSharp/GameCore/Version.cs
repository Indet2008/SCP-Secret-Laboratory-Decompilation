using MapGeneration.Holidays;
using Steam;

namespace GameCore
{
	public static class Version
	{
		public enum VersionType : byte
		{
			Release = 0,
			PublicRC = 1,
			PublicBeta = 2,
			PrivateRC = 3,
			PrivateRCStreamingForbidden = 4,
			PrivateBeta = 5,
			PrivateBetaStreamingForbidden = 6,
			Development = 7,
			Nightly = 8
		}

		public static readonly byte Major;

		public static readonly byte Minor;

		public static readonly byte Revision;

		public static readonly bool AlwaysAcceptReleaseBuilds;

		public static readonly VersionType BuildType;

		public static readonly HolidayType ActiveHoliday;

		public static readonly bool BackwardCompatibility;

		public static readonly byte BackwardRevision;

		public static readonly string DescriptionOverride;

		public static readonly string VersionString;

		public static bool PublicBeta
		{
			get
			{
				if (BuildType != VersionType.PublicBeta)
				{
					return BuildType == VersionType.PublicRC;
				}
				return true;
			}
		}

		public static bool PrivateBeta
		{
			get
			{
				VersionType buildType = BuildType;
				return buildType == VersionType.PrivateBeta || buildType == VersionType.PrivateBetaStreamingForbidden || buildType == VersionType.PrivateRC || buildType == VersionType.PrivateRCStreamingForbidden || buildType == VersionType.Development || buildType == VersionType.Nightly;
			}
		}

		public static bool ReleaseCandidate
		{
			get
			{
				VersionType buildType = BuildType;
				return buildType == VersionType.PublicRC || buildType == VersionType.PrivateRC || buildType == VersionType.PrivateRCStreamingForbidden;
			}
		}

		public static bool StreamingAllowed
		{
			get
			{
				VersionType buildType = BuildType;
				if (buildType != VersionType.PrivateBetaStreamingForbidden && buildType != VersionType.PrivateRCStreamingForbidden && buildType != VersionType.Development)
				{
					return buildType != VersionType.Nightly;
				}
				return false;
			}
		}

		public static bool ExtendedVersionCheckNeeded => BuildType != VersionType.Release;

		static Version()
		{
			Major = 14;
			Minor = 2;
			Revision = 8;
			AlwaysAcceptReleaseBuilds = false;
			BuildType = VersionType.Release;
			// Original build: HolidayType.Halloween. Disabled on request so maps, props, items and sounds use their regular versions.
			ActiveHoliday = HolidayType.None;
			BackwardCompatibility = false;
			BackwardRevision = 0;
			DescriptionOverride = null;
			VersionString = string.Format("{0}.{1}.{2}{3}", Major, Minor, Revision, (!ExtendedVersionCheckNeeded) ? string.Empty : ("-" + (DescriptionOverride ?? "release-halloween-963b276a")));
			SteamServerInfo.Version = VersionString;
		}

		public static bool CompatibilityCheck(byte sMajor, byte sMinor, byte sRevision, byte cMajor, byte cMinor, byte cRevision, bool cBackwardEnabled, byte cBackwardRevision)
		{
			if (sMajor != cMajor || sMinor != cMinor)
			{
				return false;
			}
			if (!cBackwardEnabled)
			{
				return sRevision == cRevision;
			}
			if (sRevision >= cBackwardRevision)
			{
				return sRevision <= cRevision;
			}
			return false;
		}
	}
}
