namespace UserSettings
{
	public interface IPrefsReaderWriter<T>
	{
		T Load(string key, T defValue);

		void Save(string key, T val);
	}
}
