namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentPreferences
	{
		private const string PrefKey = "_AttachmentsSetupPreference_";

		private const string PresetKey = "Preset_";

		private static string PreferencesPath(ItemType weaponId)
		{
			int num = (int)weaponId;
			return num + "_AttachmentsSetupPreference_" + GetPreset(weaponId);
		}

		public static uint GetPreferenceCodeOfPreset(ItemType weapon, int preset)
		{
			int num = (int)weapon;
			return PlayerPrefsSl.Get(num + "_AttachmentsSetupPreference_" + preset, 0u);
		}

		public static int GetPreset(ItemType weapon)
		{
			int num = (int)weapon;
			return PlayerPrefsSl.Get("Preset_" + num, 0);
		}

		public static void SetPreset(ItemType weapon, int presetId)
		{
			int num = (int)weapon;
			PlayerPrefsSl.Set("Preset_" + num, presetId);
		}

		public static uint GetSavedPreferenceCode(ItemType weapon)
		{
			return (InventoryItemLoader.AvailableItems[weapon] as Firearm).GetSavedPreferenceCode();
		}

		public static uint GetSavedPreferenceCode(this Firearm weapon)
		{
			return PlayerPrefsSl.Get(PreferencesPath(weapon.ItemTypeId), weapon.ValidateAttachmentsCode(0u));
		}

		public static void SavePreferenceCode(ItemType weapon, uint code)
		{
			PlayerPrefsSl.Set(PreferencesPath(weapon), code);
		}

		public static void SavePreferenceCode(this Firearm weapon)
		{
			SavePreferenceCode(weapon.ItemTypeId, weapon.GetCurrentAttachmentsCode());
		}
	}
}
