namespace UserSettings
{
	public class IntReaderWriter : IPrefsReaderWriter<int>
	{
		public int Load(string key, int defValue)
		{
			return PlayerPrefsSl.Get(key, defValue);
		}

		public void Save(string key, int val)
		{
			PlayerPrefsSl.Set(key, val);
		}
	}
}
