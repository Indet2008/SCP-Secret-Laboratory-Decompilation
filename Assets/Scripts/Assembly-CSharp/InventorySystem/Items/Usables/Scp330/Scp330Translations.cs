using MapGeneration.Holidays;

namespace InventorySystem.Items.Usables.Scp330
{
	public static class Scp330Translations
	{
		public enum Entry
		{
			Candies = 0
		}

		private const int CandiesOffset = 1;

		private static string TargetTranslationFile
		{
			get
			{
				if (!HolidayUtils.IsHolidayActive(HolidayType.Halloween))
				{
					return "SCP330";
				}
				return "SCP330_Halloween";
			}
		}

		public static string GetSpecificTranslation(int index, string fallback)
		{
			return TranslationReader.Get(TargetTranslationFile, index, fallback);
		}

		public static string GetEntryTranslation(Entry entry)
		{
			return GetSpecificTranslation((int)entry, entry.ToString());
		}

		public static void GetCandyTranslation(CandyKindID candyKind, out string name, out string desc, out string fx)
		{
			int num = 1 + (int)candyKind * 3;
			name = GetSpecificTranslation(num - 3, candyKind.ToString());
			desc = GetSpecificTranslation(num - 2, "No Description");
			fx = GetSpecificTranslation(num - 1, "Unknown effects");
		}
	}
}
