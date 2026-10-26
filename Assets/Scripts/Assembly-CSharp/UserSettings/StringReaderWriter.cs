namespace UserSettings
{
	public class StringReaderWriter : IPrefsReaderWriter<string>
	{
		public string Load(string key, string defValue)
		{
			return PlayerPrefsSl.Get(key, defValue);
		}

		public void Save(string key, string val)
		{
			PlayerPrefsSl.Set(key, val);
		}
	}
}
