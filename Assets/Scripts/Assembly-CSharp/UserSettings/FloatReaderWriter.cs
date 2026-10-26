namespace UserSettings
{
	public class FloatReaderWriter : IPrefsReaderWriter<float>
	{
		public float Load(string key, float defValue)
		{
			return PlayerPrefsSl.Get(key, defValue);
		}

		public void Save(string key, float val)
		{
			PlayerPrefsSl.Set(key, val);
		}
	}
}
