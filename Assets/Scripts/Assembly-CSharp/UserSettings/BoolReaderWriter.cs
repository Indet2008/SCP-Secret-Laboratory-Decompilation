namespace UserSettings
{
	public class BoolReaderWriter : IPrefsReaderWriter<bool>
	{
		public bool Load(string key, bool defValue)
		{
			return PlayerPrefsSl.Get(key, defValue);
		}

		public void Save(string key, bool val)
		{
			PlayerPrefsSl.Set(key, val);
		}
	}
}
